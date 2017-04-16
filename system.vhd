LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY system IS
	PORT (
		clk, rst, start, : in std_logic;
		done, move_op, move_dir : out std_logic;
		address_focus_matrix : in std_logic_vector (15 downto 0);
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
		total_sum, cache_address : out std_logic_vector (15 downto 0)
	);
	END COMPONENT;

	

	-- SIGNALS
	signal dma_en, dma_ack : std_logic;
	signal dma_in_addr : std_logic_vector(15 Downto 0);
	signal ram_cache_out : std_logic_vector(15 Downto 0);
	signal cache_address_read : std_logic_vector(15 downto 0);
	
	signal contrast_start, contrast_rst, contrast_done : std_logic;
	signal total_sum_out, contrast_cache_address : std_logic_vector(15 downto 0);

        BEGIN

	--Systems
	

END system;
