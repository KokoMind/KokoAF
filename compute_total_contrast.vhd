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
		finish_indexing : OUT std_logic;
		index_reg_out_out : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT fsm_compute IS
	PORT (  
		clk, rst, start, finish_indexing : IN STD_LOGIC;
		src_wr_en, r_wr_en, totalsum_wr_en : OUT STD_LOGIC;
		index_rst, index_wr_en : OUT STD_LOGIC;
		totalsum_rst : OUT STD_LOGIC;
		compute_done : OUT STD_LOGIC;
		mux_adder    : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	     );
	END COMPONENT;
	COMPONENT generic_nadder IS 
	GENERIC (n : integer := 16);
	PORT(a,b  : IN std_logic_vector(n-1  DOWNTO 0);
             cin  : IN std_logic;  
             s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             cout : OUT std_logic);
	END COMPONENT;
	COMPONENT mux_4x1_16 IS
	PORT(	sel : IN std_logic_vector(1 downto 0);
            x0,x1,x2,x3  : IN std_logic_vector(15 downto 0);
		    q : OUT std_logic_vector(15 downto 0));
	END COMPONENT;

	SIGNAL src_out, r_out, acc_out, total_sum_out, index_reg_out : std_logic_vector (15 DOWNTO 0);
	SIGNAL wr_enable_src, wr_enable_r, totalsum_enable_r : std_logic;
	SIGNAL index_rst, index_wr_en : std_logic;
	SIGNAL total_sum_rst : std_logic;
	SIGNAL dummy_cout : std_logic;
	SIGNAL mux_adder : std_logic_vector (1 downto 0);
	SIGNAL shift_amt : std_logic_vector(15 downto 0);
	SIGNAL neg_1, pos_1, neg_18, pos_18 : std_logic_vector (15 downto 0);
	SIGNAL finish_indexing : std_logic;
        BEGIN
	total_sum <= total_sum_out;
	neg_1 <= "1111111111111111";
	neg_18 <= "1111111111101110";
	pos_1 <= "0000000000000001";
	pos_18 <= "0000000000010010";
        src: reg port map(clk,rst,wr_enable_src, cache_data, src_out);
	r: reg port map(clk, rst, wr_enable_r, cache_data, r_out);
	total_sum_reg: reg port map(clk, total_sum_rst, totalsum_enable_r, acc_out, total_sum_out);
	acc: accumulator port map(src_out, r_out, total_sum_out, acc_out);
	indx : index_component port map(clk, index_rst, index_wr_en, finish_indexing, index_reg_out);
	shift_chooser : mux_4x1_16 port map(mux_adder, neg_1, neg_18, pos_1, pos_18, shift_amt);
	location_adder: generic_nadder generic map (16) port map (src_out, shift_amt, '0', cache_address, dummy_cout);
	fsm_computer : fsm_compute port map(clk, rst, start, finish_indexing, wr_enable_src, wr_enable_r, totalsum_enable_r, index_rst, index_wr_en, total_sum_rst, compute_done, mux_adder);
END a_contrast_computer;