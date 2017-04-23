LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux_16x1 IS
	GENERIC (n : integer := 16);
	PORT(	    sel : IN std_logic_vector(3 downto 0);
           	    x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15  : IN std_logic_vector(n-1 downto 0);
		    q : OUT std_logic_vector(n-1 downto 0));
END mux_16x1;

ARCHITECTURE a_mux_16x1 OF mux_16x1 IS
	BEGIN
			q <= x0 when sel = "0000"
			else x1 when sel = "0001"
			else x2 when sel = "0010"
			else x3 when sel = "0011"
			else x4 when sel = "0100"
			else x5 when sel = "0101"
			else x6 when sel = "0110"
			else x7 when sel = "0111"
			else x8 when sel = "1000"
			else x9 when sel = "1001"
			else x10 when sel = "1010"
			else x11 when sel = "1011"
			else x12 when sel = "1100"
			else x13 when sel = "1101"
			else x14 when sel = "1110"
			else x15 when sel = "1111";
END a_mux_16x1;

