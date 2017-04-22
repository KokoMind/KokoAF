
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

signal address_sig1 : unsigned (15 downto 0) := (others => '0');
signal address_sig2 : unsigned (15 downto 0) := (others => '0');
signal address_sig3 : unsigned (15 downto 0) := (others => '0');
signal address_sig4 : unsigned (15 downto 0) := (others => '0');
signal address_sig5 : unsigned (15 downto 0) := (others => '0');
signal address_sig6 : unsigned (15 downto 0) := (others => '0');
signal address_sig7 : unsigned (15 downto 0) := (others => '0');
signal address_sig8 : unsigned (15 downto 0) := (others => '0');
signal address_sig9 : unsigned (15 downto 0) := (others => '0');
signal address_sig10 : unsigned (15 downto 0) := (others => '0');
signal address_sig11 : unsigned (15 downto 0) := (others => '0');
signal address_sig12 : unsigned (15 downto 0) := (others => '0');
signal address_sig13 : unsigned (15 downto 0) := (others => '0');
signal address_sig14 : unsigned (15 downto 0) := (others => '0');
signal address_sig15 : unsigned (15 downto 0) := (others => '0');

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
address_sig1 <= unsigned(address);
dataout(15 downto 8) <= ram(to_integer(unsigned(address_sig1))) when en='1' else "ZZZZZZZZ";

address_sig2 <= unsigned(address);
dataout(23 downto 16) <= ram(to_integer(unsigned(address_sig2))) when en='1' else "ZZZZZZZZ";

address_sig3 <= unsigned(address);
dataout(31 downto 24) <= ram(to_integer(unsigned(address_sig3))) when en='1' else "ZZZZZZZZ";

address_sig4 <= unsigned(address);
dataout(39 downto 32) <= ram(to_integer(unsigned(address_sig4))) when en='1' else "ZZZZZZZZ";

address_sig5 <= unsigned(address);
dataout(47 downto 40) <= ram(to_integer(unsigned(address_sig5))) when en='1' else "ZZZZZZZZ";

address_sig6 <= unsigned(address);
dataout(55 downto 48) <= ram(to_integer(unsigned(address_sig6))) when en='1' else "ZZZZZZZZ";

address_sig7 <= unsigned(address);
dataout(63 downto 56) <= ram(to_integer(unsigned(address_sig7))) when en='1' else "ZZZZZZZZ";

address_sig8 <= unsigned(address);
dataout(71 downto 64) <= ram(to_integer(unsigned(address_sig8))) when en='1' else "ZZZZZZZZ";

address_sig9 <= unsigned(address);
dataout(79 downto 72) <= ram(to_integer(unsigned(address_sig9))) when en='1' else "ZZZZZZZZ";

address_sig10 <= unsigned(address);
dataout(87 downto 80) <= ram(to_integer(unsigned(address_sig10))) when en='1' else "ZZZZZZZZ";

address_sig11 <= unsigned(address);
dataout(95 downto 88) <= ram(to_integer(unsigned(address_sig11))) when en='1' else "ZZZZZZZZ";

address_sig12 <= unsigned(address);
dataout(103 downto 96) <= ram(to_integer(unsigned(address_sig12))) when en='1' else "ZZZZZZZZ";

address_sig13 <= unsigned(address);
dataout(111 downto 104) <= ram(to_integer(unsigned(address_sig13))) when en='1' else "ZZZZZZZZ";

address_sig14 <= unsigned(address);
dataout(119 downto 112) <= ram(to_integer(unsigned(address_sig14))) when en='1' else "ZZZZZZZZ";

address_sig15 <= unsigned(address);
dataout(127 downto 120) <= ram(to_integer(unsigned(address_sig15))) when en='1' else "ZZZZZZZZ";
END a_nvm;
