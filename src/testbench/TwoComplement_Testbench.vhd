-------------------------------------------------------------------------------
--
-- Title       : TwoComplement_Testbench
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it & d.gargaro@campus.unimib.it
-- Company     : Università degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity TwoComplement_Testbench is
end TwoComplement_Testbench;

architecture TwoComplement_Testbench_behavior of TwoComplement_Testbench is

	-- Component declaration
    component TwoComplement is
        generic (Nb : integer := 8);
        port (
			data_in : in  STD_LOGIC_VECTOR(Nb-1 downto 0);
            data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
        );
    end component TwoComplement;
	
	-- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal data_in_tb : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal data_out_tb : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin

	-- Instantiate the TwoComplement module
    TwoComplement_tb : TwoComplement generic map (Nb => N) port map (data_in_tb, data_out_tb);
	
	-- Main process
    main_process: process
    begin
		
		wait for CLK_PERIOD;
        
		data_in_tb <= "01010101";
        wait for CLK_PERIOD;
		
		data_in_tb <= "00000000";
		wait for CLK_PERIOD;
		
		data_in_tb <= "11110000";

    end process;

end TwoComplement_Testbench_behavior;
