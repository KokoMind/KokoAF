
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY nvm IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(7 DOWNTO 0);
		dataout : OUT std_logic_vector(127 DOWNTO 0));
END ENTITY nvm;

ARCHITECTURE a_nvm OF nvm IS

COMPONENT generic_nadder IS
		GENERIC (n : integer := 16);
		PORT(	 a,b  : IN std_logic_vector(n-1  DOWNTO 0);
            		 cin  : IN std_logic;  
           		 s    : OUT std_logic_vector(n-1 DOWNTO 0);    
             		 cout : OUT std_logic);
END COMPONENT;

TYPE ram_type IS ARRAY(0 TO 65535) OF std_logic_vector(7 DOWNTO 0);
SIGNAL ram : ram_type;

signal address_sig1 : std_logic_vector (15 downto 0);
signal dntcare1 : std_logic;

signal address_sig2 : std_logic_vector (15 downto 0);
signal dntcare2 : std_logic;

signal address_sig3 : std_logic_vector (15 downto 0);
signal dntcare3 : std_logic;

signal address_sig4 : std_logic_vector (15 downto 0);
signal dntcare4 : std_logic;

signal address_sig5 : std_logic_vector (15 downto 0);
signal dntcare5 : std_logic;

signal address_sig6 : std_logic_vector (15 downto 0);
signal dntcare6 : std_logic;

signal address_sig7 : std_logic_vector (15 downto 0);
signal dntcare7 : std_logic;

signal address_sig8 : std_logic_vector (15 downto 0);
signal dntcare8 : std_logic;

signal address_sig9 : std_logic_vector (15 downto 0);
signal dntcare9 : std_logic;

signal address_sig10 : std_logic_vector (15 downto 0);
signal dntcare10 : std_logic;

signal address_sig11 : std_logic_vector (15 downto 0);
signal dntcare11 : std_logic;

signal address_sig12 : std_logic_vector (15 downto 0);
signal dntcare12 : std_logic;

signal address_sig13 : std_logic_vector (15 downto 0);
signal dntcare13 : std_logic;

signal address_sig14 : std_logic_vector (15 downto 0);
signal dntcare14 : std_logic;

signal address_sig15 : std_logic_vector (15 downto 0);
signal dntcare15 : std_logic;

BEGIN
	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN  
				IF wr = '1' THEN
					ram(to_integer(unsigned(address))) <= datain;
				END IF;
			END IF;
	END PROCESS;
	
	dataout (7 downto 0) <= ram(to_integer(unsigned(address)));
	addr1 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(1, 16)),'0',address_sig1,dntcare1);
	dataout(15 downto 8) <= ram(to_integer(unsigned(address_sig1)));

	addr2 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(2, 16)),'0',address_sig2,dntcare2);
	dataout(23 downto 16) <= ram(to_integer(unsigned(address_sig2)));

	addr3 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(3, 16)),'0',address_sig3,dntcare3);
	dataout(31 downto 24) <= ram(to_integer(unsigned(address_sig3)));

	addr4 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(4, 16)),'0',address_sig4,dntcare4);
	dataout(39 downto 32) <= ram(to_integer(unsigned(address_sig4)));

	addr5 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(5, 16)),'0',address_sig5,dntcare5);
	dataout(47 downto 40) <= ram(to_integer(unsigned(address_sig5)));

	addr6 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(6, 16)),'0',address_sig6,dntcare6);
	dataout(55 downto 48) <= ram(to_integer(unsigned(address_sig6)));

	addr7 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(7, 16)),'0',address_sig7,dntcare7);
	dataout(63 downto 56) <= ram(to_integer(unsigned(address_sig7)));

	addr8 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(8, 16)),'0',address_sig8,dntcare8);
	dataout(71 downto 64) <= ram(to_integer(unsigned(address_sig8)));

	addr9 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(9, 16)),'0',address_sig9,dntcare9);
	dataout(79 downto 72) <= ram(to_integer(unsigned(address_sig9)));

	addr10 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(10, 16)),'0',address_sig10,dntcare10);
	dataout(87 downto 80) <= ram(to_integer(unsigned(address_sig10)));

	addr11 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(11, 16)),'0',address_sig11,dntcare11);
	dataout(95 downto 88) <= ram(to_integer(unsigned(address_sig11)));

	addr12 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(12, 16)),'0',address_sig12,dntcare12);
	dataout(103 downto 96) <= ram(to_integer(unsigned(address_sig12)));

	addr13 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(13, 16)),'0',address_sig13,dntcare13);
	dataout(111 downto 104) <= ram(to_integer(unsigned(address_sig13)));

	addr14 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(14, 16)),'0',address_sig14,dntcare14);
	dataout(119 downto 112) <= ram(to_integer(unsigned(address_sig14)));

	addr15 : generic_nadder generic map (16) port map (address,std_logic_vector(to_unsigned(15, 16)),'0',address_sig15,dntcare15);
	dataout(127 downto 120) <= ram(to_integer(unsigned(address_sig15)));

END a_nvm;
