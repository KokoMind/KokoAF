LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY contrast_computer IS
	PORT (
		start, clk, rst: in std_logic;
		compute_done : out std_logic;
		cache_data : in std_logic_vector (15 downto 0);
		total_sum, cache_address : out std_logic_vector (15 downto 0)
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
	COMPONENT index_component IS
	PORT(   clk,rst,wr_en : IN std_logic;
		index_reg_out_out : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;

	SIGNAL src_out, r_out, acc_out, total_sum_out, index_reg_out : std_logic_vector (15 DOWNTO 0);
	SIGNAL wr_enable_src, wr_enable_r, totalsum_enable_r : std_logic;
	SIGNAL index_rst, index_wr_en : std_logic;
	SIGNAL total_sum_rst : std_logic;

        BEGIN
	total_sum <= total_sum_out;
        src: reg port map(clk,rst,wr_enable_src, cache_data, src_out);
	r: reg port map(clk, rst, wr_enable_r, cache_data, r_out);
	total_sum_reg: reg port map(clk, total_sum_rst, totalsum_enable_r, acc_out, total_sum_out);
	acc: accumulator port map(src_out, r_out, total_sum_out, acc_out);
	indx : index_component port map(clk, index_rst, index_wr_en, index_reg_out);

END a_contrast_computer;