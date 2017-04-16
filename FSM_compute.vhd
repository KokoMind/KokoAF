LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FSM IS
	PORT (  
		clk, rst, en, start, finish_indexing : IN STD_LOGIC;
		src_wr_en, r_wr_en, totalsum_wr_en : OUT STD_LOGIC;
		index_rst, index_wr_en : OUT STD_LOGIC;
		totalsum_rst : OUT STD_LOGIC;
		compute_done : OUT STD_LOGIC;
	     );
END FSM;

ARCHITECTURE FSM_A OF FSM IS

type state_type  is (do_nothing, init, inc, load_src, load_r1, compute1, load_r2, compute2, load_r3, compute3, load_r4, compute4, compute_finish); 
signal state : state_type;
signal next_state : state_type;
BEGIN
	PROCESS (state)
	BEGIN
			CASE state is 
				when do_nothing =>
					if  start = '0' or en = '0' then
						next_state <= do_nothing;
						src_wr_en <= '0';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '0';
						totalsum_rst <= '0';
						compute_done <= '0';
					else
					 	next_state <= init;
						src_wr_en <= '0';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '0';
						totalsum_rst <= '0';
						compute_done <= '0';
					end if;
				when init =>
					next_state <= inc;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '1';
					index_rst <= '1';
					totalsum_rst <= '1';
					compute_done <= '0';
				when inc =>
					next_state <= load_src;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '1';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
				when load_src => 
					if  finish_indexing = '1' then
						next_state <= compute_finish;
						src_wr_en <= '0';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '0';
						totalsum_rst <= '0';
						compute_done <= '0';
					else
					 	next_state <= load_r1;
						src_wr_en <= '1';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '0';
						totalsum_rst <= '0';
						compute_done <= '0';
					end if;
				when load_r1 => 
					next_state <= compute1;
					-- out signals
				when compute1 => 
					next_state <= load_r2;
					-- out signals
				when load_r2 => 
					next_state <= compute2;
					-- out signals
				when compute2 => 
					next_state <= load_r3;
					-- out signals
				when load_r3 => 
					next_state <= compute3;
					-- out signals
				when compute3 => 
					next_state <= load_r4;
					-- out signals
				when load_r4 => 
					next_state <= compute4;
					-- out signals
				when compute4 => 
					next_state <= inc;
					-- out signals
				when compute_finish => 
					next_state <= do_nothing;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '1';
			END CASE;
	END PROCESS;

	PROCESS (clk, rst)
		BEGIN
			IF rst = '1' THEN
				state  <= compute_rst;
			ELSIF rising_edge(clk) THEN 
				state  <= next_state;
			END IF;
	END PROCESS;


End FSM_A;

