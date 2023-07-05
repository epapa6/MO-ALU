-------------------------------------------------------------------------------
--
-- Title       : CU_ALU_Testbench
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

entity CU_ALU_Testbench is
end CU_ALU_Testbench;

architecture CU_ALU_Testbench_behavior of CU_ALU_Testbench is

	-- Component declaration
    component CU_ALU is
        port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	operation_code : in STD_LOGIC_VECTOR(2 downto 0);
		 	read_complete : in STD_LOGIC;
		 	write_complete : in STD_LOGIC;
		 	operation_a : out STD_LOGIC_VECTOR(1 downto 0);
		 	operation_b : out STD_LOGIC_VECTOR(1 downto 0);
		 	operation_complete : out STD_LOGIC;
		 	state : out STD_LOGIC_VECTOR(4 downto 0)
	    );
    end component CU_ALU;
	
	-- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
	-- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal operation_code_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal read_complete_tb : STD_LOGIC := '0';
	signal write_complete_tb : STD_LOGIC := '0';
	signal operation_a_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal operation_b_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal operation_complete_tb : STD_LOGIC := '0';
	signal state_tb : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	
begin

	-- Instantiate the CU_ALU module
    CU_ALU_tb : CU_ALU port map (clk_tb, reset_tb, enable_tb, operation_code_tb, read_complete_tb, write_complete_tb, operation_a_tb, operation_b_tb, operation_complete_tb, state_tb);
	
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
        wait for CLK_PERIOD * 13;
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
        
		read_complete_tb <= '0';
        wait for CLK_PERIOD;
		
		read_complete_tb <= '1';
		operation_code_tb <= "110";
		wait for CLK_PERIOD;
		
		wait for CLK_PERIOD * 5;
		
		write_complete_tb <= '1';
		operation_code_tb <= "010";
		wait for CLK_PERIOD;
		
		write_complete_tb <= '0';

    end process;

	
end CU_ALU_Testbench_behavior;
