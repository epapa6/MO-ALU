-------------------------------------------------------------------------------
--
-- Title       : Mux_1x3_Testbench
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

entity Mux_1x3_Testbench is
end Mux_1x3_Testbench;

architecture Mux_1x3_Testbench_behavior of Mux_1x3_Testbench is

	-- Component declaration
    component Mux_1x3 is
        generic (Nb : integer := 8);
        port (
			selector : in STD_LOGIC_VECTOR(1 downto 0);
			data_in_0 : in  STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_1 : in  STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_2 : in  STD_LOGIC_VECTOR(Nb-1 downto 0);
            data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
        );
    end component Mux_1x3;
	
	-- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
	signal selector_tb : STD_LOGIC_VECTOR(1 downto 0);
    signal data_in_0_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal data_in_1_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal data_in_2_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal data_out_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    
begin

	-- Instantiate the Mux_1x3 module
    Mux_1x3_tb : Mux_1x3 generic map (Nb => N) port map (selector_tb, data_in_0_tb, data_in_1_tb, data_in_2_tb, data_out_tb);
	
	-- Main process
    main_process: process
    begin
		
		wait for CLK_PERIOD;
        
		data_in_0_tb <= "01010101";
		data_in_1_tb <= "11111111";
		data_in_2_tb <= "10101010";
        wait for CLK_PERIOD;
		
		selector_tb <= "00";
		wait for CLK_PERIOD;
		
		selector_tb <= "01";
		wait for CLK_PERIOD;
		
		selector_tb <= "10";
		wait for CLK_PERIOD;
		
		selector_tb <= "11";

    end process;

end Mux_1x3_Testbench_behavior;
