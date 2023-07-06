-------------------------------------------------------------------------------
--
-- Title       : NbCounter_Testbench
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

entity NbCounter_Testbench is
end NbCounter_Testbench;

architecture NbCounter_Testbench_behavior of NbCounter_Testbench is

	-- Component declaration
    component NbCounter is
        generic(Nb : integer := 8);
		port(
			clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
		 	enable : in STD_LOGIC;
		 	output : out STD_LOGIC
	    );
    end component NbCounter;
	
    -- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal clk_tb : STD_LOGIC := '0';
    signal reset_tb : STD_LOGIC := '0';
    signal enable_tb : STD_LOGIC := '0';
    signal output_tb : STD_LOGIC := '0';

begin
   
    -- Instantiate the Counter module
    NbCounter_tb: NbCounter generic map (Nb => N) port map (clk_tb, reset_tb, enable_tb, output_tb);

    -- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
        clk_tb <= not clk_tb;
    end process;
	
	-- Enable process
    enable_process: process
    begin
		wait for CLK_PERIOD / 2;
        wait for CLK_PERIOD * 2;
		enable_tb <= not enable_tb;
		wait for CLK_PERIOD * 9;
		enable_tb <= not enable_tb;
    end process;
	
	-- Reset process
    reset_process: process
    begin
		wait for CLK_PERIOD;
		reset_tb <= not reset_tb;
        wait for CLK_PERIOD * 10;
		reset_tb <= not reset_tb;
    end process;
	
	-- Main process
	main_process: process
	begin

	   wait for CLK_PERIOD ;
       
	end process;

end NbCounter_Testbench_behavior;
