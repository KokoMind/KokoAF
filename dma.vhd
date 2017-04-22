LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dma IS
	PORT(
		load_en,clk,rst : IN std_logic; 
		nvm_start_address : IN std_logic_vector(15 DOWNTO 0);
		nvm_address_out : OUT std_logic_vector(15 DOWNTO 0); 
		ack : OUT std_logic;
		cache_address_out : OUT std_logic_vector(8 DOWNTO 0)
	);
END dma;


ARCHITECTURE a_dma OF dma IS

	signal zerovec, vec1, vec256, vec16, nvm_address_in, counter_in, counter_out, nvm_address_out_rd : std_logic_vector (15 downto 0);
	signal cache_address_in, vec18, vec19, cache_address_out_rd : std_logic_vector (8 downto 0);
	signal dummy_cout1, dummy_cout2, dummy_cout3, reset : std_logic;

	COMPONENT FSM_dma IS
	PORT(
		load_en,clk,rst : IN std_logic; 
		ack, reset : OUT std_logic;
		counter : IN std_logic_vector (15 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
    	END COMPONENT;

	COMPONENT preset_reg IS
	PORT(clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT preset_reg_9 IS
	PORT( clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(8 DOWNTO 0);
		  q : OUT std_logic_vector(8 DOWNTO 0));
	END COMPONENT;

	COMPONENT reg IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;
BEGIN
	zerovec <= "0000000000000000";
	vec1 <= "0000000000000001";
	vec16 <= "0000000000010000";
	vec256 <= "0000000100000000";
	vec19 <= "000010011";
	vec18 <= "000010010";
	cache_address_out <= cache_address_out_rd;
	nvm_address_out <= nvm_address_out_rd;

	fdma: FSM_dma port map(load_en, clk, rst, ack, reset, counter_out);

	reg_nvm: preset_reg port map(clk, reset, '1', nvm_start_address, nvm_address_in, nvm_address_out_rd);
	adder1: generic_nadder generic map (16) port map (nvm_address_out_rd, vec256, '0', nvm_address_in, dummy_cout1);
	
	reg_cache: preset_reg_9 port map(clk, reset, '1', vec19, cache_address_in, cache_address_out_rd);
	adder2: generic_nadder generic map (9) port map (cache_address_out_rd, vec18, '0', cache_address_in, dummy_cout2);

	counter1: reg port map(clk,reset, '1', counter_in, counter_out);
	adder3: generic_nadder generic map (16) port map (counter_out, zerovec, '1', counter_in, dummy_cout3);
end a_dma;