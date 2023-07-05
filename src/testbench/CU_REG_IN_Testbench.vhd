-------------------------------------------------------------------------------
--
-- Title       : CU_REG_IN_Testbench
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it
-- Company     : Università degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CU_REG_IN_Testbench is
end CU_REG_IN_Testbench;

architecture CU_REG_IN_Testbench_behavior of CU_REG_IN_Testbench is

	-- Component declaration
    component CU_REG_IN is
	 	port(
	 	 	clk : in STD_LOGIC;
	 	 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	control_bit : in STD_LOGIC;
		 	count_a : in STD_LOGIC;
		 	count_b : in STD_LOGIC;
		 	enable_a : out STD_LOGIC;
		 	enable_b : out STD_LOGIC;
		 	reset_counter : out STD_LOGIC;
		 	read_complete : out STD_LOGIC;
		 	state : out STD_LOGIC_VECTOR(4 downto 0) 
	 	);
    end component CU_REG_IN;
	
	-- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal control_bit_tb : STD_LOGIC := '0';
	signal count_a_tb : STD_LOGIC := '0';
	signal count_b_tb : STD_LOGIC := '0';
	signal enable_a_tb : STD_LOGIC := '0';
	signal enable_b_tb : STD_LOGIC := '0';
	signal reset_counter_tb : STD_LOGIC := '0';
	signal read_complete_tb : STD_LOGIC := '0';
	signal state_tb : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

begin

	-- Instantiate the CU_REG_IN module
    CU_REG_IN_tb : CU_REG_IN port map (clk_tb, reset_tb, enable_tb, control_bit_tb, count_a_tb, count_b_tb, enable_a_tb, enable_b_tb, reset_counter_tb, read_complete_tb, state_tb);
	
	-- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
        clk_tb <= not clk_tb;
    end process;
	
	-- Reset process
    reset_process: process
    begin
		wait for CLK_PERIOD;
		reset_tb <= not reset_tb;
        wait for CLK_PERIOD * (N * 5);
		reset_tb <= not reset_tb;
    end process;
	
	-- Enable process
    enable_process: process
    begin
        wait for CLK_PERIOD * 2;
		enable_tb <= not enable_tb;
    end process;

    -- Main process
    main_process: process
    begin
		
		wait for CLK_PERIOD;
        
		control_bit_tb <= '0';
        wait for CLK_PERIOD * 4;
		
		control_bit_tb <= '1';
		wait for CLK_PERIOD * N;
		count_a_tb <= '1';
		
		wait for CLK_PERIOD * N;
		count_b_tb <= '1';
		
        wait for CLK_PERIOD * N;

    end process;
	

end CU_REG_IN_Testbench_behavior;
