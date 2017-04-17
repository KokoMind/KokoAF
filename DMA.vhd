
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dma IS
PORT(
	enable,clk,clk_mem : IN std_logic; 
	in_addr : IN std_logic_vector(15  DOWNTO 0); 
	ack : OUT std_logic;
	cache_out : OUT std_logic_vector(15  DOWNTO 0);
	cache_address_read : IN std_logic_vector(15 DOWNTO 0)
);
END dma;

ARCHITECTURE a_dma OF dma IS

Component tri IS
	PORT(
		  en: IN std_logic;
		  input: IN std_logic_vector(15 DOWNTO 0);
		  output: OUT std_logic_vector(15 DOWNTO 0));
END Component;

Component preset_reg IS
	PORT( clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
END Component ;

COMPONENT generic_nadder IS
		GENERIC (n : integer := 16);
		PORT(	 a,b  : IN std_logic_vector(n-1  DOWNTO 0);
            		 cin  : IN std_logic;  
           		 s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             		 cout : OUT std_logic);
END COMPONENT;

Component mux_2x1_16 IS
	PORT(	sel : IN std_logic;
            x1,x2  : IN std_logic_vector(15 downto 0);
			q : OUT std_logic_vector(15 DOWNTO 0));
END COMPONENT;

Component data_ram IS
	PORT(	clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0));
END  Component;

Component data_ram256 IS
	PORT(	clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0));
END  Component;

signal ram_out1,cur_addr,new_addr,cnt,new_cnt,cnt2,new_cnt2,add_value1,add_value3,cache_value: std_logic_vector(15 DOWNTO 0);
signal cache_addr,new_cache_addr,new_cache_addr_preset,zerovec,new_cnt_in :std_logic_vector(15 DOWNTO 0);
signal s1,s3,rst,s_cache,dntcare: std_logic;
signal mux1_a,mux1_b :std_logic_vector(15 DOWNTO 0);
signal vec15,vec1,vec3,vec19, vec16 :std_logic_vector(15 DOWNTO 0);
signal cache_address_in : std_logic_vector(15 DOWNTO 0);

BEGIN
mux1_a<="0000000000000001";
mux1_b<="0000000011110001";
zerovec<= "0000000000000000";
vec15<= "0000000000001111";
vec16<= "0000000000010000";
vec19<="0000000000010011";
vec1<="0000000000000001";
vec3<="0000000000000011";
rst<= not enable;
zerovec<= (OTHERS => '0');
cache_address :   preset_reg  port map (clk,rst,enable,vec19,new_cache_addr,cache_addr);
cur_address :   preset_reg  port map (clk,rst,enable,in_addr,new_addr,cur_addr);
count_inner :   preset_reg  port map (clk,rst,enable,zerovec,new_cnt_in,cnt);
count_outer :   preset_reg  port map (clk,rst,enable,zerovec,new_cnt2,cnt2);
ram : data_ram256 port map(clk_mem,'1', enable,cur_addr, zerovec,ram_out1 );
cache: data_ram port map(clk_mem,'1',enable,cache_address_in, ram_out1 ,cache_out );

cache_address_in <= cache_addr when enable = '1'
		else cache_address_read;

s1 <= '1'  when cnt=vec15  
	   else '0' ;

new_cnt_in <= zerovec  when cnt=vec15
	      else new_cnt;

mux1: mux_2x1_16 port map( s1,mux1_a,mux1_b,add_value1);

mux3: mux_2x1_16 port map(s1,zerovec,vec1,add_value3);

mux_cache: mux_2x1_16 port map(s1,vec1,vec3,cache_value);

cache_adder : generic_nadder generic map (16) port map (cache_addr,cache_value,'0',new_cache_addr,dntcare);

address_adder : generic_nadder generic map (16) port map (cur_addr,add_value1,'0',new_addr,dntcare);
adder_inner : generic_nadder generic map (16) port map (cnt,vec1,'0',new_cnt,dntcare);
adder_outer : generic_nadder generic map (16) port map (cnt2,add_value3,'0',new_cnt2,dntcare);


ack <= '1' when cnt = vec15 and cnt2 = vec15
	   else '0' ;
end a_dma;