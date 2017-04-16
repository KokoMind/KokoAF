LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg_1bit IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic;
		  q : OUT std_logic);
END reg_1bit;

ARCHITECTURE a_reg_1bit OF reg_1bit IS
	BEGIN
		PROCESS(clk,rst)
			BEGIN
				IF rst = '1' THEN
					q <= '0';
				ELSIF en = '1' AND rising_edge(Clk) THEN
					q <= d;
				END IF;
		END PROCESS;
END a_reg_1bit;
