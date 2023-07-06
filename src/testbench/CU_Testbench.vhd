-------------------------------------------------------------------------------
--
-- Title       : CU_Testbench
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it & d.gargaro@campus.unimib.it
-- Company     : Universita' degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CU_Testbench is
end CU_Testbench;

architecture CU_Testbench_behavior of CU_Testbench is

	-- Component declaration
	component CU is
	 	generic (Nb : integer := 8);
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	control_bit : in STD_LOGIC;
		 	enable_a : out STD_LOGIC;
		 	enable_b : out STD_LOGIC;
		 	enable_r : out STD_LOGIC;
		 	operation_code : in STD_LOGIC_VECTOR(2 downto 0);
		 	operation_a : out STD_LOGIC_VECTOR(1 downto 0);
		 	operation_b : out STD_LOGIC_VECTOR(1 downto 0)
	 	);
	end component CU;
	
	-- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period 
	
	-- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal control_bit_tb : STD_LOGIC := '0';
	signal enable_a_tb : STD_LOGIC := '0';
	signal enable_b_tb : STD_LOGIC := '0';
	signal enable_r_tb : STD_LOGIC := '0';
	signal operation_code_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal operation_a_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal operation_b_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

begin

	-- Instantiate the CU module
	CU_tb : CU generic map (Nb => N) port map (clk_tb, reset_tb, enable_tb, control_bit_tb, enable_a_tb, enable_b_tb, enable_r_tb, operation_code_tb, operation_a_tb, operation_b_tb);
	
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
        wait for CLK_PERIOD * 30;
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
		operation_code_tb <= "001";
        wait for CLK_PERIOD;
		
		control_bit_tb <= '1';
		operation_code_tb <= "101";
        wait for CLK_PERIOD;
		
		control_bit_tb <= '0';
		wait for CLK_PERIOD * 15;
		
    end process;
	
end CU_Testbench_behavior;
