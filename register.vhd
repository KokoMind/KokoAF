LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg IS
	GENERIC (n : integer := 16);
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END reg;

ARCHITECTURE a_reg OF reg IS
	BEGIN
		PROCESS(clk,rst)
			BEGIN
				IF rst = '1' THEN
					q <= (OTHERS=>'0');
				ELSIF en = '1' AND rising_edge(Clk) THEN
					q <= d;
				END IF;
		END PROCESS;
END a_reg;
