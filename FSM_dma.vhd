LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FSM_dma IS
PORT(
	load_en,clk,rst : IN std_logic; 
	ack, reset : OUT std_logic;
	counter_outer : IN std_logic_vector (15 DOWNTO 0);
	counter_inner : IN std_logic_vector (3 DOWNTO 0)
);
END FSM_dma;

ARCHITECTURE a_FSM_dma OF FSM_dma IS
	type state_type  is (do_nothing, load, finish); 
	signal state : state_type;
	signal next_state : state_type;
	signal vec15 : std_logic_vector (15 downto 0);
	signal vec15_4 : std_logic_vector (3 downto 0);
BEGIN
	vec15 <= "0000000000001111";
	vec15_4 <= "1111";
	PROCESS (state, load_en, counter_outer, counter_inner)
	BEGIN
		CASE state is 
			when do_nothing =>
					ack <= '0';
					reset <= '1';
			     		if load_en = '0' then
						next_state <= do_nothing;
					else 
						next_state <= load;
					end if;
			when load =>
					ack <= '0';
					reset <= '0';
					if counter_outer = vec15 and counter_inner = vec15_4 then
						next_state <= finish;
					else
						next_state <= load;
					end if;
			when finish =>
					ack <= '1';
					reset <= '1';
					next_state <= do_nothing;
			when others =>
					ack <= '0';
					reset <= '1';
					next_state <= do_nothing;

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
								
end a_FSM_dma;