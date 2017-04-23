LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dma IS
	PORT(
		load_en,clk,rst : IN std_logic; 
		nvm_start_address : IN std_logic_vector(15 DOWNTO 0);
		nvm_address_out : OUT std_logic_vector(15 DOWNTO 0); 
		ack : OUT std_logic;
		cache_address_out : OUT std_logic_vector(8 DOWNTO 0);
		nvm_data_out : IN std_logic_vector(127 downto 0);
		nvm_data_out_selected : OUT std_logic_vector(7 DOWNTO 0)
	);
END dma;


ARCHITECTURE a_dma OF dma IS

	signal zerovec, vec1, vec256, vec16, nvm_address_in, counter_outer_in, counter_outer_out, nvm_address_out_rd : std_logic_vector (15 downto 0);
	signal cache_address_in, vec18, vec19, cache_address_out_rd, zerovec_9 : std_logic_vector (8 downto 0);
	signal counter_inner_out, nvm_data_selector, counter_inner_in, zerovec_4 : std_logic_vector (3 downto 0);
	signal dummy_cout1, dummy_cout2, dummy_cout3, dummy_cout4, reset, inc_counter_outer : std_logic;

	COMPONENT FSM_dma IS
	PORT(
		load_en,clk,rst : IN std_logic; 
		ack, reset : OUT std_logic;
		counter_outer : IN std_logic_vector (15 DOWNTO 0);
		counter_inner : IN std_logic_vector (3 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
    	END COMPONENT;

	COMPONENT mux_16x1 IS
	GENERIC (n : integer := 16);
	PORT(	    sel : IN std_logic_vector(3 downto 0);
           	    x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15  : IN std_logic_vector(n-1 downto 0);
		    q : OUT std_logic_vector(n-1 downto 0));
	END COMPONENT;

	COMPONENT preset_reg IS
	GENERIC (n : integer := 16);
	PORT(clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT reg IS
	GENERIC (n : integer := 16);
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
	END COMPONENT;
BEGIN
	zerovec <= (OTHERS => '0');
	zerovec_9 <= (OTHERS => '0');
	zerovec_4 <= (OTHERS => '0');
	vec1 <= "0000000000000001";
	vec16 <= "0000000000010000";
	vec256 <= "0000000100000000";
	vec19 <= "000010011";
	vec18 <= "000010010";
	cache_address_out <= cache_address_out_rd;
	nvm_address_out <= nvm_address_out_rd;

	fdma: FSM_dma port map(load_en, clk, rst, ack, reset, counter_outer_out, counter_inner_out);

	--nvm control

	reg_nvm: preset_reg generic map (16) port map(clk, reset, inc_counter_outer, nvm_start_address, nvm_address_in, nvm_address_out_rd);
	adder1: generic_nadder generic map (16) port map (nvm_address_out_rd, zerovec, '1', nvm_address_in, dummy_cout1);
	
	counter_outer: reg generic map (16) port map(clk,reset, inc_counter_outer, counter_outer_in, counter_outer_out);
	adder3: generic_nadder generic map (16) port map (counter_outer_out, zerovec, '1', counter_outer_in, dummy_cout3);

	--cache control

	reg_cache: preset_reg generic map (9) port map(clk, reset, '1', vec19, cache_address_in, cache_address_out_rd);
	adder2: generic_nadder generic map (9) port map (cache_address_out_rd, zerovec_9, '1', cache_address_in, dummy_cout2);

	counter_inner: reg generic map (4) port map(clk,reset, '1', counter_inner_in, counter_inner_out);
	adder4: generic_nadder generic map (4) port map (counter_inner_out, zerovec_4, '1', counter_inner_in, dummy_cout4);

	inc_counter_outer <= '1' when counter_inner_out = "1111" else '0';
	nvm_data_selector <= counter_inner_out;

	mux_nvm_data : mux_16x1 generic map (8) port map (nvm_data_selector, nvm_data_out (7 downto 0), nvm_data_out (15 downto 8), nvm_data_out (23 downto 16), nvm_data_out (31 downto 24), nvm_data_out (39 downto 32), nvm_data_out (47 downto 40), 
				nvm_data_out (55 downto 48), nvm_data_out (63 downto 56), nvm_data_out (71 downto 64), nvm_data_out (79 downto 72), nvm_data_out (87 downto 80), nvm_data_out (95 downto 88), nvm_data_out (103 downto 96), nvm_data_out (111 downto 104), 
				nvm_data_out (119 downto 112), nvm_data_out (127 downto 120), nvm_data_out_selected);

end a_dma;