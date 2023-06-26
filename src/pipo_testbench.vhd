-------------------------------------------------------------------------------
--
-- Title       : pipo_testbench
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

entity pipo_testbench is
end pipo_testbench;

architecture pipo_testbench_behavior of pipo_testbench is
	
	-- Component declaration
    component pipo is
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
    end component pipo;
	
	constant N: integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal clk_tb    : std_logic := '0';
    signal reset_tb  : std_logic := '0';
    signal enable_tb : std_logic := '0';
    signal data_in_tb   : std_logic_vector(N-1 downto 0);
    signal data_out_tb      : std_logic_vector(N-1 downto 0);
    
    

begin
    -- Instantiate the PIPO module
    pipo_tb: pipo
    generic map (
        Nb => N
    )
    port map (
        clk    => clk_tb,
        reset  => reset_tb,
        enable => enable_tb,
        data_in   => data_in_tb,
        data_out      => data_out_tb
    );

    -- Clock process
    clk_process: process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
        
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        reset_tb <= '0'; 
        enable_tb <= '0';
        data_in_tb <= (others => '0');
        wait for CLK_PERIOD;

        reset_tb <= '1'; 
        enable_tb <= '1'; 
        data_in_tb <= "10101010"; 
        
        wait for CLK_PERIOD * N + 2 ns;

        reset_tb <= '0'; 
        wait for CLK_PERIOD;

        enable_tb <= '0';
        data_in_tb <= (others => '0'); 
		
		wait for 3 ns;

    end process;

end pipo_testbench_behavior;
