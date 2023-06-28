-------------------------------------------------------------------------------
--
-- Title       : PIPO_Testbench
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

entity PIPO_Testbench is
end PIPO_Testbench;

architecture PIPO_Testbench_behavior of PIPO_Testbench is
	
	-- Component declaration
    component PIPO is
        generic (
            Nb : integer := 8
        );
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            enable: in  std_logic;
            data_in  : in  std_logic_vector(Nb-1 downto 0);
            data_out     : out std_logic_vector(Nb-1 downto 0)
        );
    end component PIPO;
	
	constant N: integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal clk_tb    : std_logic := '0';
    signal reset_tb  : std_logic := '0';
    signal enable_tb : std_logic := '0';
    signal data_in_tb : std_logic_vector(N-1 downto 0);
    signal data_out_tb : std_logic_vector(N-1 downto 0);
    
    

begin
    -- Instantiate the PIPO module
    PIPO_tb: PIPO generic map (Nb => N) port map (clk_tb, reset_tb, enable_tb, data_in_tb, data_out_tb);

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
		wait for CLK_PERIOD;
		reset_tb <= not reset_tb;
        wait for CLK_PERIOD * 4;
		reset_tb <= not reset_tb;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
  
        data_in_tb <= (others => '0');
        wait for CLK_PERIOD;
 
        data_in_tb <= "10101010"; 
        wait for CLK_PERIOD * N + 2 ns;

        data_in_tb <= (others => '0'); 
		wait for 3 ns;

    end process;

end PIPO_testbench_behavior;
