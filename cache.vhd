LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY cache IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(8 DOWNTO 0);
		datain  : IN  std_logic_vector(127 DOWNTO 0);
		dataout : OUT std_logic_vector(7 DOWNTO 0));
END ENTITY cache;

ARCHITECTURE a_cache OF cache IS

TYPE ram_type IS ARRAY(0 TO 511) OF std_logic_vector(7 DOWNTO 0);
SIGNAL ram : ram_type;

type addresses is array (1 to 15) of unsigned (8 downto 0);
signal address_sig : addresses;

BEGIN
	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN  
				IF wr = '1' THEN
					ram(to_integer(unsigned(address))) <= datain(7 downto 0);
					ram(to_integer(unsigned(address_sig(1)))) <= datain(15 downto 8);
					ram(to_integer(unsigned(address_sig(2)))) <= datain(23 downto 16);
					ram(to_integer(unsigned(address_sig(3)))) <= datain(31 downto 24);
					ram(to_integer(unsigned(address_sig(4)))) <= datain(39 downto 32);
					ram(to_integer(unsigned(address_sig(5)))) <= datain(47 downto 40);
					ram(to_integer(unsigned(address_sig(6)))) <= datain(55 downto 48);
					ram(to_integer(unsigned(address_sig(7)))) <= datain(63 downto 56);
					ram(to_integer(unsigned(address_sig(8)))) <= datain(71 downto 64);
					ram(to_integer(unsigned(address_sig(9)))) <= datain(79 downto 72);
					ram(to_integer(unsigned(address_sig(10)))) <= datain(87 downto 80);
					ram(to_integer(unsigned(address_sig(11)))) <= datain(95 downto 88);
					ram(to_integer(unsigned(address_sig(12)))) <= datain(103 downto 96);
					ram(to_integer(unsigned(address_sig(13)))) <= datain(111 downto 104);
					ram(to_integer(unsigned(address_sig(14)))) <= datain(119 downto 112);
					ram(to_integer(unsigned(address_sig(15)))) <= datain(127 downto 120);
				END IF;
			END IF;
	END PROCESS;
	dataout <= ram(to_integer(unsigned(address))) when en = '1' else "ZZZZZZZZ";
	
	loop1: FOR i IN 1 TO 15 GENERATE
        	gx: address_sig(i) <= unsigned(address) + i;
	END GENERATE;
	
END a_cache;
