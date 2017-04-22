LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FSM_compute IS
	PORT (  
		clk, rst, start, finish_indexing : IN STD_LOGIC;
		src_wr_en, r_wr_en, totalsum_wr_en : OUT STD_LOGIC;
		index_rst, index_wr_en : OUT STD_LOGIC;
		totalsum_rst : OUT STD_LOGIC;
		compute_done : OUT STD_LOGIC;
		mux_adder    : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		state_no    : OUT std_logic_vector(3 downto 0)
	     );
END FSM_compute;

ARCHITECTURE FSM_compute_A OF FSM_compute IS

type state_type  is (do_nothing, init, inc, load_src, load_r1, compute1, load_r2, compute2, load_r3, compute3, load_r4, compute4, compute_finish); 
signal state : state_type;
signal next_state : state_type;
BEGIN
	PROCESS (state, start, finish_indexing)
	BEGIN
			CASE state is 
				when do_nothing =>
					if  start = '0' then
						next_state <= do_nothing;
						src_wr_en <= '0';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '1';
						totalsum_rst <= '1';
						compute_done <= '0';
						mux_adder <= "000";
						state_no <= "0000";
					else
					 	next_state <= init;
						src_wr_en <= '0';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '1';
						totalsum_rst <= '1';
						compute_done <= '0';
						mux_adder <= "000";
						state_no <= "0000";
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
					mux_adder <= "000";
					state_no <= "0001";
				when inc =>
					next_state <= load_src;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '1';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "0010";
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
						mux_adder <= "000";
						state_no <= "0011";
					else
					 	next_state <= load_r1;
						src_wr_en <= '1';
						r_wr_en <= '0';
						totalsum_wr_en <= '0';
						index_wr_en <= '0';
						index_rst <= '0';
						totalsum_rst <= '0';
						compute_done <= '0';
						mux_adder <= "000";
						state_no <= "0011";
					end if;
				when load_r1 => 
					next_state <= compute1;
					src_wr_en <= '0';
					r_wr_en <= '1';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "001";
					state_no <= "0100";
				when compute1 => 
					next_state <= load_r2;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '1';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "0101";
				when load_r2 => 
					next_state <= compute2;
					src_wr_en <= '0';
					r_wr_en <= '1';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "010";
					state_no <= "0110";
				when compute2 => 
					next_state <= load_r3;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '1';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "0111";
				when load_r3 => 
					next_state <= compute3;
					src_wr_en <= '0';
					r_wr_en <= '1';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "011";
					state_no <= "1000";
				when compute3 => 
					next_state <= load_r4;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '1';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "1001";
				when load_r4 => 
					next_state <= compute4;
					src_wr_en <= '0';
					r_wr_en <= '1';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "100";
					state_no <= "1010";
				when compute4 => 
					next_state <= inc;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '1';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "1011";
				when compute_finish => 
					next_state <= do_nothing;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '0';
					totalsum_rst <= '0';
					compute_done <= '1';
					mux_adder <= "000";
					state_no <= "1100";
				when others => 
					next_state <= do_nothing;
					src_wr_en <= '0';
					r_wr_en <= '0';
					totalsum_wr_en <= '0';
					index_wr_en <= '0';
					index_rst <= '1';
					totalsum_rst <= '1';
					compute_done <= '0';
					mux_adder <= "000";
					state_no <= "0000";
			END CASE;
	END PROCESS;

	PROCESS (clk, rst)
		BEGIN
			IF rst = '1' THEN
				state  <= do_nothing;
			ELSIF rising_edge(clk) THEN 
				state  <= next_state;
			END IF;
	END PROCESS;


End FSM_compute_A;

