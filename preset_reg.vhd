LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY preset_reg IS
	PORT( clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
END preset_reg;

ARCHITECTURE a_reg OF preset_reg IS
	BEGIN
		PROCESS(clk,rst)
			BEGIN
				IF rst = '1' THEN
					q <= preset;
				ELSIF en = '1' AND rising_edge(Clk) THEN
					q <= d;
				END IF;
		END PROCESS;
END a_reg;
