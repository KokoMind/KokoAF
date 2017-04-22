LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY system IS
	PORT (
		clk, rst, start, move_done : in std_logic;
		done, move, direction : out std_logic;
		address_focus_matrix : in std_logic_vector (15 downto 0)
	);
END system;

ARCHITECTURE a_system OF system IS

	COMPONENT mux_2x1_9 IS
	PORT(	sel : IN std_logic;
            x1,x2  : IN std_logic_vector(8 downto 0);
			q : OUT std_logic_vector(8 DOWNTO 0));
	END COMPONENT;

	COMPONENT reg IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT nvm IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(7 DOWNTO 0);
		dataout : OUT std_logic_vector(127 DOWNTO 0));
	END COMPONENT;

	COMPONENT cache IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(8 DOWNTO 0);
		datain  : IN  std_logic_vector(127 DOWNTO 0);
		dataout : OUT std_logic_vector(7 DOWNTO 0));
	END COMPONENT;

	COMPONENT dma IS
	PORT(
		load_en,clk,rst : IN std_logic; 
		nvm_start_address : IN std_logic_vector(15 DOWNTO 0);
		nvm_address_out : OUT std_logic_vector(15 DOWNTO 0); 
		ack : OUT std_logic;
		cache_address_out : OUT std_logic_vector(8 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT contrast_computer IS
	PORT (
		start, clk, rst: in std_logic;
		compute_done : out std_logic;
		cache_data_in : in std_logic_vector (7 downto 0);
		cache_address : out std_logic_vector (8 downto 0);
		total_sum : out std_logic_vector(31 downto 0);
		state_no : out std_logic_vector(3 downto 0);
		index_reg_out_out : out std_logic_vector(8 downto 0);
		src_out_out, r_out_out : out std_logic_vector (15 DOWNTO 0);
		acc_out_out : out std_logic_vector(31 downto 0)
	);
	END COMPONENT;

	COMPONENT comparator IS
	PORT (
		a, b : in std_logic_vector (31 downto 0);
		a_greaterthan_b	:  out std_logic
	);
	END COMPONENT;

	COMPONENT reg_32 IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(31 DOWNTO 0);
		  q : OUT std_logic_vector(31 DOWNTO 0));
	END COMPONENT;

	COMPONENT FSM IS
	PORT (  
		clk, start, rst, load_ack, compute_done, move_done, flag_in, worse : in std_logic;
		outer_address : in std_logic_vector (15 downto 0);
		load_en, compute_en, move, flag_out, done : out std_logic;
		total_sum_bak_out : out std_logic_vector (31 downto 0);
		address : out std_logic_vector (15 downto 0);
		total_sum_bak_in, total_sum_new : in std_logic_vector (31 downto 0);
		in_direction : in std_logic;
		out_direction : out std_logic
	     );
	END COMPONENT;

	COMPONENT reg_1bit IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic;
		  q : OUT std_logic);
	END COMPONENT;

	-- SIGNALS
	signal nvm_start_address, nvm_address_out : std_logic_vector (15 downto 0);
	signal total_sum_bak_in, total_sum_bak_out, total_sum_new : std_logic_vector (31 downto 0);	
	signal cache_address_read, cache_address_write, cache_address : std_logic_vector (8 downto 0);
	signal nvm_data_in, cache_data_out : std_logic_vector (7 downto 0);
	signal nvm_data_out : std_logic_vector (127 downto 0);
	SIGNAL state_no : std_logic_vector(3 downto 0);
	SIGNAL index_reg_out : std_logic_vector(8 downto 0);
	SIGNAL src_out, r_out : std_logic_vector (15 DOWNTO 0);
	SIGNAL acc_out : std_logic_vector(31 downto 0);
	signal out_direction, in_direction, worse, load_en, load_ack, compute_en, compute_done, flag_out, flag_in : std_logic;
        BEGIN
	
	direction1 : reg_1bit port map(clk, rst, '1', out_direction, in_direction);
	flag1 : reg_1bit port map(clk, rst, '1', flag_out, flag_in);
	total_sum_bak1 : reg_32 port map(clk, rst, '1', total_sum_bak_out, total_sum_bak_in);
	comparator1 : comparator port map(total_sum_bak_in, total_sum_new, worse);
	
	nvm_data_in <= "00000000";
	nvm1 : nvm port map(clk, load_en, '0', nvm_address_out, nvm_data_in, nvm_data_out);
	mux_cache : mux_2x1_9 port map (load_en, cache_address_read, cache_address_write, cache_address);
	cache1 : cache port map(clk, '1', load_en, cache_address, nvm_data_out, cache_data_out);
	dma1 : dma port map(load_en, clk, rst, nvm_start_address, nvm_address_out, load_ack, cache_address_write);
	
	contraster1 : contrast_computer port map(compute_en, clk, rst, compute_done, cache_data_out, cache_address_read, total_sum_new, state_no, index_reg_out, src_out, r_out, acc_out);
	
	fsm1 : FSM port map(clk, start, rst, load_ack, compute_done, move_done, flag_in, worse, address_focus_matrix, load_en, compute_en, move, flag_out, done, total_sum_bak_out, nvm_start_address, total_sum_bak_in, total_sum_new, in_direction, out_direction);

	direction <= out_direction;
END a_system;
