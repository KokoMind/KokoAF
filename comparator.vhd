LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY comparator IS
	PORT (
		a, b : in std_logic_vector (31 downto 0);
		a_greaterthan_b	:  out std_logic
	);
END comparator;

ARCHITECTURE a_comparator OF comparator IS
     COMPONENT generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
     END COMPONENT;
     SIGNAL notb, sub_out : std_logic_vector (31 downto 0);
     SIGNAL sub_cout : std_logic;
     BEGIN
	notb <= not b;
	subtractor: generic_nadder generic map (32) port map (a,notb,'1',sub_out,sub_cout);
	a_greaterthan_b <= sub_cout;
END a_comparator;
