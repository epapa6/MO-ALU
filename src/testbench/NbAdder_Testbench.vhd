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
	 	 	carry_in : in STD_LOGIC;
		 	sum : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	    );
    end component NbAdder;
	
	-- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
	signal a_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal b_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal carry_in_tb : STD_LOGIC;
	signal sum_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	
begin

	-- Instantiate the NbAdder module
    NbAdder_tb : NbAdder generic map (Nb => N) port map (a_tb, b_tb, carry_in_tb, sum_tb);
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;

        a_tb <= "11111111";
		b_tb <= "10000001";
		carry_in_tb <= '0';
        wait for CLK_PERIOD;
		
		a_tb <= "01010101";
		b_tb <= "00010001";
		carry_in_tb <= '1';
		wait for CLK_PERIOD;
		
		a_tb <= "11111111";
		b_tb <= "00010001";
		carry_in_tb <= '1';
		
    end process;

end NbAdder_Testbench_behavior;
