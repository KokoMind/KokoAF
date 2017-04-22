LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY preset_reg IS
	GENERIC (n : integer := 16);
	PORT( clk,rst,en : IN std_logic;
		  preset, d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END preset_reg;

ARCHITECTURE a_preset_reg OF preset_reg IS
	BEGIN
		PROCESS(clk,rst)
			BEGIN
				IF rst = '1' THEN
					q <= preset;
				ELSIF rising_edge(Clk) THEN
					if en = '1' then
						q <= d;
					end if;
				END IF;
		END PROCESS;
END a_preset_reg;
