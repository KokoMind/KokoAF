LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg_32 IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(31 DOWNTO 0);
		  q : OUT std_logic_vector(31 DOWNTO 0));
END reg_32;

ARCHITECTURE a_reg_32 OF reg_32 IS
	BEGIN
		PROCESS(clk,rst)
			BEGIN
				IF rst = '1' THEN
					q <= (OTHERS=>'0');
				ELSIF en = '1' AND rising_edge(Clk) THEN
					q <= d;
				END IF;
		END PROCESS;
END a_reg_32;
