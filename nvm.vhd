
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY nvm IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(7 DOWNTO 0);
		dataout : OUT std_logic_vector(127 DOWNTO 0));
END ENTITY nvm;

ARCHITECTURE a_nvm OF nvm IS

TYPE ram_type IS ARRAY(0 TO 65535) OF std_logic_vector(7 DOWNTO 0);
SIGNAL ram : ram_type;

type addresses is array (1 to 15) of unsigned (15 downto 0);
signal address_sig : addresses;

BEGIN
	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN  
				IF wr = '1' THEN
					ram(to_integer(unsigned(address))) <= datain;
				END IF;
			END IF;
	END PROCESS;
	
	dataout (7 downto 0) <= ram(to_integer(unsigned(address))) when en='1' else "ZZZZZZZZ";
	dataout(15 downto 8) <= ram(to_integer(unsigned(address_sig(1)))) when en='1' else "ZZZZZZZZ";
	dataout(23 downto 16) <= ram(to_integer(unsigned(address_sig(2)))) when en='1' else "ZZZZZZZZ";
	dataout(31 downto 24) <= ram(to_integer(unsigned(address_sig(3)))) when en='1' else "ZZZZZZZZ";
	dataout(39 downto 32) <= ram(to_integer(unsigned(address_sig(4)))) when en='1' else "ZZZZZZZZ";
	dataout(47 downto 40) <= ram(to_integer(unsigned(address_sig(5)))) when en='1' else "ZZZZZZZZ";
	dataout(55 downto 48) <= ram(to_integer(unsigned(address_sig(6)))) when en='1' else "ZZZZZZZZ";
	dataout(63 downto 56) <= ram(to_integer(unsigned(address_sig(7)))) when en='1' else "ZZZZZZZZ";
	dataout(71 downto 64) <= ram(to_integer(unsigned(address_sig(8)))) when en='1' else "ZZZZZZZZ";
	dataout(79 downto 72) <= ram(to_integer(unsigned(address_sig(9)))) when en='1' else "ZZZZZZZZ";
	dataout(87 downto 80) <= ram(to_integer(unsigned(address_sig(10)))) when en='1' else "ZZZZZZZZ";
	dataout(95 downto 88) <= ram(to_integer(unsigned(address_sig(11)))) when en='1' else "ZZZZZZZZ";
	dataout(103 downto 96) <= ram(to_integer(unsigned(address_sig(12)))) when en='1' else "ZZZZZZZZ";
	dataout(111 downto 104) <= ram(to_integer(unsigned(address_sig(13)))) when en='1' else "ZZZZZZZZ";
	dataout(119 downto 112) <= ram(to_integer(unsigned(address_sig(14)))) when en='1' else "ZZZZZZZZ";
	dataout(127 downto 120) <= ram(to_integer(unsigned(address_sig(15)))) when en='1' else "ZZZZZZZZ";

	loop1: FOR i IN 1 TO 15 GENERATE
        	gx: address_sig(i) <= unsigned(address) + i;
	END GENERATE;
END a_nvm;
