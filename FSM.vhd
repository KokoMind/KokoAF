LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FSM IS
	PORT (  
		clk, start, rst, load_ack, compute_done, move_done, flag_in, worse : in std_logic;
		outer_address : in std_logic_vector (15 downto 0);
		load_en, compute_en, move, flag_out, done : out std_logic;
		total_sum_bak_out : out std_logic_vector (15 downto 0);
		address : out std_logic_vector (15 downto 0);
		total_sum_bak_in, total_sum_new : in std_logic_vector (15 downto 0);
		in_direction : in std_logic;
		out_direction : out std_logic
	     );
END FSM;

ARCHITECTURE FSM_A OF FSM IS

type state_type  is (do_nothing, load_focus_matrix, set_direction, move_lens, compute_total_contrast, check, finish); 
signal state : state_type;
signal next_state : state_type;
signal MAX : std_logic_vector (15 downto 0);
BEGIN
	MAX <= (OTHERS => '1');
	PROCESS (state)
	BEGIN
			CASE state is 
				when do_nothing =>
						load_en <= '0';
						compute_en <= '0';
						move <= '0';
						flag_out <= '0';
						done <= '0';
						total_sum_bak_out <= total_sum_bak_in;
						if  start = '0' then
							next_state <= do_nothing;
						else 
							next_state <= load_focus_matrix;
						end if;
				when load_focus_matrix =>
						load_en <= '1';
						compute_en <= '0';
						move <= '0';
						flag_out <= flag_in;
						done <= '0';
						total_sum_bak_out <= total_sum_bak_in;
						if load_ack = '1' then 
							next_state <= compute_total_contrast;
						else next_state <= load_focus_matrix;
						end if;
				when set_direction =>
						out_direction <= not in_direction;
						load_en <= '0';
						compute_en <= '0';
						move <= '0';
						flag_out <= flag_in;
						done <= '0';
						total_sum_bak_out <= total_sum_bak_in;
						next_state <= move_lens;
				when move_lens =>
						load_en <= '0';
						compute_en <= '0';
						move <= '1';
						flag_out <= flag_in;
						done <= '0';
						total_sum_bak_out <= total_sum_bak_in;
						if move_done = '1' then
							next_state <= load_focus_matrix;
						else 
							next_state <= move_lens;
						end if;
				when compute_total_contrast =>
						load_en <= '0';
						compute_en <= '1';
						move <= '0';
						flag_out <= flag_in;
						done <= '0';
						total_sum_bak_out <= total_sum_bak_in;
						if compute_done = '1' then 
							next_state <= check;
						else next_state <= compute_total_contrast;
						end if;
				when check =>
						load_en <= '0';
						compute_en <= '0';
						move <= '0';
						done <= '0';
						total_sum_bak_out <= total_sum_new;
						if total_sum_bak_in = MAX then
							flag_out <= '0';
							next_state <= set_direction;
						elsif flag_in = '0' and worse = '1' then
							flag_out <= '1';
							next_state <= set_direction;
						elsif flag_in = '1' and worse = '1' then 
							flag_out <= flag_in;
							next_state <= finish;
						else 
							flag_out <= flag_in;
							next_state <= move_lens;
						end if;
				when finish =>
						load_en <= '0';
						compute_en <= '0';
						move <= '0';
						flag_out <= flag_in;
						done <= '1';
						total_sum_bak_out <= total_sum_bak_in;
						next_state <= finish;			
						
			END CASE;
	END PROCESS;

	address <= outer_address;

	PROCESS (clk, rst)
		BEGIN
			IF rst = '1' THEN
				state  <= do_nothing;
			ELSIF rising_edge(clk) THEN 
				state  <= next_state;
			END IF;
	END PROCESS;


End FSM_A;

