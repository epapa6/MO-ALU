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

component DFlipFlop is
	port(
	 	 clk : in STD_LOGIC;
	 	 reset : in STD_LOGIC;
		 enable : in STD_LOGIC;
		 d : in STD_LOGIC;
		 q : out STD_LOGIC
	     );
end component;

constant CLK_PERIOD : time := 10 ns; -- Clock period

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
		clk_tb <= not clk_tb;
		wait for CLK_PERIOD / 2;
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
        wait for CLK_PERIOD * 4;
		reset_tb <= not reset_tb;
    end process;
	
	-- Stimulus process
	stimulus_process: process
    begin
		d_tb <= '1';
		wait for CLK_PERIOD + 2 ns;
		d_tb <= '0';
		wait for CLK_PERIOD + 3 ns;
    end process;

end DFlipFlop_Testbench_behavior;
