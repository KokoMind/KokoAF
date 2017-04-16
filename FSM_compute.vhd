LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FSM IS
	PORT (IR, F : IN  STD_LOGIC_vector(15 downto 0);
		CLK,CLK2,RST : IN STD_LOGIC;
		ALUout : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		Incrementer, R0out, R0in, R1out, R1in, PCout, PCin, SPout, SPin : OUT STD_LOGIC;
		MARin, MDRout, MDRin, IRin, IRout, RD, WRT, INC, DEC, ADD, Zin, Zout, Yin, Yout, TEMPin, TEMPout  : OUT STD_LOGIC);
END FSM;


ARCHITECTURE FSM_A OF FSM IS

type state_type  is (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, Trst); 
signal state : state_type;
signal next_state : state_type;
BEGIN
	PROCESS (state)
	BEGIN
		
			CASE state is 
				when Trst =>
					next_state <= T0;
				Incrementer <= '0';
				R0out <= '0';
				R1out  <= '0';
				PCout  <= '0';
				SPout  <= '0';
			 	SPin  <= '0';
				PCin  <= '0';
				 R0in <= '0';
				R1in  <= '0';
				MARin <= '0';
				MDRout <= '0';
				MDRin <= '0';
				IRin <= '0';
				IRout <= '0';
				RD <= '0';
				WRT <= '0';
				INC <= '0';
				DEC <= '0';
				ADD <= '0';
				TEMPin <= '0';
				TEMPout <= '0';
				Zin <= '0';
				Zout <= '0';
				Yin <= '0';
				Yout <= '0';
				ALUout <= "00000";
			END CASE;


	END PROCESS;

	PROCESS (CLK, RST)
		BEGIN
			IF RST = '1' THEN
				state  <= Trst;

			ELSIF rising_edge(CLK) THEN 
				state  <= next_state;
			END IF;
	END PROCESS;


End FSM_A;

