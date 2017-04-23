
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY nvm IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(127 DOWNTO 0);
		dataout : OUT std_logic_vector(127 DOWNTO 0));
END ENTITY nvm;

ARCHITECTURE a_nvm OF nvm IS

TYPE ram_type IS ARRAY(0 TO 65535) OF std_logic_vector(127 DOWNTO 0);
SIGNAL ram : ram_type;
SIGNAL Z : std_logic_vector (127 downto 0);

BEGIN
Z <= (OTHERS => 'Z');

	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN  
				IF wr = '1' THEN
					ram(to_integer(unsigned(address))) <= datain;
				END IF;
			END IF;
	END PROCESS;
	
	dataout <= ram(to_integer(unsigned(address))) when en='1' else Z;

END a_nvm;
