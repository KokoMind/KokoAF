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

	COMPONENT reg IS
	PORT( clk,rst,en : IN std_logic;
		  d : IN  std_logic_vector(15 DOWNTO 0);
		  q : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;

	COMPONENT dma IS
	PORT(
		enable,clk,clk_mem : IN std_logic; 
		in_addr : IN std_logic_vector(15  DOWNTO 0); 
		ack : OUT std_logic;
		cache_out : OUT std_logic_vector(15  DOWNTO 0);
		cache_address_read : IN std_logic_vector(15 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT contrast_computer IS
	PORT (
		start, clk, rst: in std_logic;
		compute_done : out std_logic;
		cache_data : in std_logic_vector (15 downto 0);
		cache_address : out std_logic_vector (15 downto 0);
		total_sum : out std_logic_vector(31 downto 0)
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
	signal fsm_address_out, cache_data, cache_address : std_logic_vector (15 downto 0);
	signal total_sum_bak_in, total_sum_bak_out, total_sum_new : std_logic_vector (31 downto 0);	
	signal out_direction, in_direction, worse, load_en, load_ack, compute_en, compute_done, flag_out, flag_in : std_logic;
        BEGIN
	
	direction1 : reg_1bit port map(clk, rst, '1', out_direction, in_direction);
	flag1 : reg_1bit port map(clk, rst, '1', flag_out, flag_in);
	total_sum_bak1 : reg_32 port map(clk, rst, '1', total_sum_bak_out, total_sum_bak_in);
	comparator1 : comparator port map(total_sum_bak_in, total_sum_new, worse);
	dma1 : dma port map(load_en, clk, clk, fsm_address_out, load_ack, cache_data, cache_address);
	contraster1 : contrast_computer port map(compute_en, clk, rst, compute_done, cache_data, cache_address, total_sum_new);
	
	fsm1 : FSM port map(clk, start, rst, load_ack, compute_done, move_done, flag_in, worse, address_focus_matrix, load_en, compute_en, move, flag_out, done, total_sum_bak_out, fsm_address_out, total_sum_bak_in, total_sum_new, in_direction, out_direction);

	direction <= out_direction;
END a_system;
