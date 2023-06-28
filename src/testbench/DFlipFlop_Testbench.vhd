-------------------------------------------------------------------------------
--
-- Title       : DFlipFlop_Testbench
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

entity DFlipFlop_Testbench is
end DFlipFlop_Testbench;

architecture DFlipFlop_Testbench_behavior of DFlipFlop_Testbench is

	-- Component declaration
	component DFlipFlop is
		port(
	 		clk : in STD_LOGIC;
	 		reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			d : in STD_LOGIC;
			q : out STD_LOGIC
	    );
	end component;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
	-- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal d_tb : STD_LOGIC := '0';
	signal q_tb : STD_LOGIC := '0';

begin
	
	-- Instantiate the DFlipFlop module
	DFlipFlop_tb : DFlipFlop port map (clk_tb, reset_tb, enable_tb, d_tb, q_tb);
	
	-- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
		clk_tb <= not clk_tb;
    end process;
	
	-- Enable process
    enable_process: process
    begin
        wait for CLK_PERIOD * 2;
		enable_tb <= not enable_tb;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD * 4 + 3 ns;
		reset_tb <= not reset_tb;
    end process;
	
	-- Main process
	main_process: process
    begin
		
		wait for CLK_PERIOD;
		
		d_tb <= '1';
		wait for CLK_PERIOD + 2 ns;
		
		d_tb <= '0';

    end process;

end DFlipFlop_Testbench_behavior;
