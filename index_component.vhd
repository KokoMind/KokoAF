LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY index_component IS
	PORT(   clk,rst,index_reg_rst,wr_en : IN std_logic;
		finish_indexing : OUT std_logic;
		index_reg_out_out : OUT std_logic_vector(8 DOWNTO 0));
END index_component;

ARCHITECTURE a_index_component OF index_component IS
	
Component preset_reg IS
	GENERIC (n : integer := 16);
	PORT( clk,rst,en : IN std_logic;
		preset: IN std_logic_vector(n-1 DOWNTO 0);
		  d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END Component;

Component generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
END Component;

Component mux_4x1 IS
	GENERIC (n : integer := 16);
	PORT(	sel : IN std_logic_vector(1 downto 0);
            x0,x1,x2,x3  : IN std_logic_vector(n-1 downto 0);
		    q : OUT std_logic_vector(n-1 downto 0));
END Component;

SIGNAL index_reg_in : std_logic_vector(8 DOWNTO 0);
SIGNAL index_reg_en : std_logic;
SIGNAL index_reg_out : std_logic_vector(8 DOWNTO 0);

SIGNAL Onevec : std_logic_vector(8 DOWNTO 0);
SIGNAL Threevec : std_logic_vector(8 DOWNTO 0);
SIGNAL Zerovec : std_logic_vector(8 DOWNTO 0);
SIGNAL Eighteenvec : std_logic_vector(8 DOWNTO 0);
SIGNAL adder_mux_sel : std_logic_vector(1 DOWNTO 0);

SIGNAL adder_a : std_logic_vector(8 DOWNTO 0);
SIGNAL adder_b : std_logic_vector(8 DOWNTO 0);
SIGNAL adder_cin : std_logic;
SIGNAL adder_out : std_logic_vector(8 DOWNTO 0);
SIGNAL adder_cout : std_logic;

SIGNAL finish_indexing_out : std_logic;

BEGIN

-- init signals

Onevec <= "000000001";
Threevec <= "000000011";
Zerovec <= "000000000";
Eighteenvec <= "000010010";
index_reg_out_out <= index_reg_out;
adder_a <= index_reg_out;
adder_cin <= '0';
index_reg_in <= adder_out;

adder_mux_sel <= "00" when rst = '1' or finish_indexing_out = '1' or wr_en = '0'
		else "10" when index_reg_out = "000100010" or index_reg_out = "000110100" or index_reg_out = "001000110" or index_reg_out = "001011000" or index_reg_out = "001101010" or index_reg_out = "001111100" or index_reg_out = "010001110" or index_reg_out = "010100000" or index_reg_out = "010110010" or index_reg_out = "011000100" or index_reg_out = "011010110" or index_reg_out = "011101000" or index_reg_out = "011111010" or index_reg_out = "100001100" or index_reg_out = "100011110" or index_reg_out = "100110000"
		else "01";
		
finish_indexing_out <= '1' when index_reg_out = "100110011"
		else '0';
		-- finish indexing in the last row
finish_indexing <= finish_indexing_out;

index_reg_en <= wr_en; -- enable the register when rst of the system or wr_en
		
index_reg : preset_reg generic map (9) port map (clk, index_reg_rst, index_reg_en, Eighteenvec, index_reg_in, index_reg_out);
index_add : generic_nadder generic map (9) port map (adder_a, adder_b, adder_cin, adder_out, adder_cout);
index_mux_add : mux_4x1 generic map(9) port map (adder_mux_sel, Zerovec, Onevec, Threevec, Zerovec, adder_b);

END a_index_component;