-------------------------------------------------------------------------------
--
-- Title       : SIPO_Testbench
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

entity SIPO_Testbench is
end SIPO_Testbench;

architecture SIPO_Testbench_behavior of SIPO_Testbench is
	
	-- Component declaration
    component SIPO is
        generic (Nb : integer := 8);
        port (
            clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            data_in : in  STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
        );
    end component SIPO;
	
    -- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal clk_tb : STD_LOGIC := '0';
    signal reset_tb : STD_LOGIC := '0';
    signal enable_tb : STD_LOGIC := '0';
    signal data_in_tb : STD_LOGIC := '0';
    signal data_out_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    
begin
    
    -- Instantiate the SIPO module
    SIPO_tb	: SIPO generic map (Nb => N) port map (clk_tb, reset_tb, enable_tb, data_in_tb, data_out_tb);

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
		wait for CLK_PERIOD * 8;
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
		
        wait for CLK_PERIOD;
        
        data_in_tb <= '0';
        wait for CLK_PERIOD;
		
		data_in_tb <= '1';
        wait for CLK_PERIOD;
		
		data_in_tb <= '0';
        wait for CLK_PERIOD;
		
		data_in_tb <= '1';
        wait for CLK_PERIOD;
		
		data_in_tb <= '0';
        wait for CLK_PERIOD;
		
		data_in_tb <= '1';
        wait for CLK_PERIOD;
		
		data_in_tb <= '0';
        wait for CLK_PERIOD;
		
		data_in_tb <= '1';

    end process;

end SIPO_Testbench_behavior;
