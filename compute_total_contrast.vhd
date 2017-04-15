LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY contrast_computer IS
	PORT (
		start, clk, rst: in std_logic;
		compute_done : out std_logic;
		total_sum, cache_address, cache_data : out std_logic_vector (15 downto 0)
	);
END contrast_computer;

ARCHITECTURE a_contrast_computer OF contrast_computer IS
	COMPONENT reg IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT accumulator IS
	PORT (
		src,r,total_sum : in std_logic_vector (15 downto 0);
		output	:	out std_logic_vector (15 downto 0)
	);
	END COMPONENT;

	SIGNAL src_out, r_out, acc_out, total_sum_out : std_logic_vector (15 DOWNTO 0);
	SIGNAL wr_enable_src, wr_enable_r, totalsum_enable_r : std_logic;
        BEGIN
        src: reg port map(clk,rst,wr_enable_src, cache_data, src_out);
	r: reg port map(clk, rst, wr_enable_r, cache_data, r_out);
	total_sum: reg port map(clk, rst, totalsum_enable_r, acc_out, total_sum_out);
	acc: accumulator port map(src_out, r_out, total_sum_out, acc_out);
END a_contrast_computer;