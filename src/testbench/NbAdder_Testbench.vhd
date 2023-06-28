-------------------------------------------------------------------------------
--
-- Title       : NbAdder_Testbench
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

entity NbAdder_Testbench is
end NbAdder_Testbench;

architecture NbAdder_Testbench_behavior of NbAdder_Testbench is

	-- Component declaration
    component NbAdder is
        generic (Nb : integer := 8);
        port(
	 	 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 	b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 	sum : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	    );
    end component NbAdder;
	
	-- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
	signal a_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal b_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal sum_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	
begin

	-- Instantiate the NbAdder module
    NbAdder_tb : NbAdder generic map (Nb => N) port map (a_tb, b_tb, sum_tb);
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		a_tb <= "01010101";
		b_tb <= "00010001";
		wait for CLK_PERIOD;
		
		a_tb <= "01010101";
		b_tb <= "00010001";
		wait for CLK_PERIOD;
		
        a_tb <= "01011111";
		b_tb <= "01000000";
        wait for CLK_PERIOD;
		
		a_tb <= "00100000";
		b_tb <= "01100000";
        wait for CLK_PERIOD;
		
		a_tb <= "01100000";
		b_tb <= "00100000";
        wait for CLK_PERIOD;
		
		a_tb <= "01100000";
		b_tb <= "01100000";
        wait for CLK_PERIOD;
		
		a_tb <= "10000000";
		b_tb <= "10000000";
		wait for CLK_PERIOD;
		
		a_tb <= "11000000";
		b_tb <= "10000000";
		wait for CLK_PERIOD;
		
		a_tb <= "10000000";
		b_tb <= "11000000";
		wait for CLK_PERIOD;
		
		a_tb <= "10100000";
		b_tb <= "10100000";
		
    end process;

end NbAdder_Testbench_behavior;
