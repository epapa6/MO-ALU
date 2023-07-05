-------------------------------------------------------------------------------
--
-- Title       : CU_REG_OUT_Testbench
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

entity CU_REG_OUT_Testbench is
end CU_REG_OUT_Testbench;

architecture CU_REG_OUT_Testbench_behavior of CU_REG_OUT_Testbench is

	-- Component declaration
	component CU_REG_OUT is
        port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 enable : in STD_LOGIC;
		 operation_complete : in STD_LOGIC;
		 enable_r : out STD_LOGIC;
		 write_complete : out STD_LOGIC;
		 state : out STD_LOGIC_VECTOR(4 downto 0)
	 );
    end component CU_REG_OUT;
	
	-- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
	-- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal operation_complete_tb : STD_LOGIC := '0';
	signal enable_r_tb : STD_LOGIC := '0';
	signal write_complete_tb : STD_LOGIC := '0';
	signal state_tb : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	
begin

	-- Instantiate the CU_REG_OUT module
	CU_REG_OUT_tb : CU_REG_OUT port map (clk_tb, reset_tb, enable_tb, operation_complete_tb, enable_r_tb, write_complete_tb, state_tb);
	
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
        wait for CLK_PERIOD * 8;
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
        
		operation_complete_tb <= '0';
        wait for CLK_PERIOD * 2;
		
		operation_complete_tb <= '1';
		wait for CLK_PERIOD;
		
		operation_complete_tb <= '0';
		wait for CLK_PERIOD * 4;
		
		operation_complete_tb <= '1';
		wait for CLK_PERIOD;
		
		operation_complete_tb <= '0';
		wait for CLK_PERIOD;
		
    end process;

end CU_REG_OUT_Testbench_behavior;
