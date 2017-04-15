LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY accumulator IS
	PORT (
		src,r,total_sum : in std_logic_vector (15 downto 0);
		output	:	out std_logic_vector (15 downto 0)
	);
END accumulator;

ARCHITECTURE a_accumulator OF accumulator IS
     COMPONENT generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
     END COMPONENT;
     SIGNAL sub_out, notr, not_sub_out, zero_vec, absolute_out : std_logic_vector (15 downto 0);
     SIGNAL sub_cout, sign, do_abs, absolute_cout, dummy_cout : std_logic;
     BEGIN
	notr <= not r;
	sign <= sub_out(15);
	zero_vec <= (OTHERS => '0');
	subtractor: generic_nadder generic map (16) port map (src,notr,'1',sub_out,sub_cout);
	not_sub_out <= sub_out when sign = '0'
	       else not sub_out;
	do_abs <= '0' when sign = '0'
		  else '1';
	absolute: generic_nadder generic map (16) port map (not_sub_out,zero_vec,do_abs,absolute_out,absolute_cout);
	accumulate: generic_nadder generic map (16) port map (absolute_out,total_sum,'0',output,dummy_cout);
END a_accumulator;
