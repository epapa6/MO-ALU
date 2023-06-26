-------------------------------------------------------------------------------
--
-- Title       : alu_testbench
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

entity alu_testbench is
end alu_testbench;

architecture alu_testbench_behavior of alu_testbench is

	-- Component declaration
	component alu is
        generic (
            Nb : integer := 8
        );
        port (
            operation   : in  std_logic_vector(2 downto 0);
            data_in_0  : in  std_logic_vector(Nb-1 downto 0);
			data_in_1  : in  std_logic_vector(Nb-1 downto 0);
            data_out     : out std_logic_vector(Nb-1 downto 0)
        );
    end component alu;
	
	constant N: integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
    signal operation_tb   : std_logic_vector(2 downto 0);
	signal data_in_0_tb   : std_logic_vector(N-1 downto 0);
    signal data_in_1_tb   : std_logic_vector(N-1 downto 0);
    signal data_out_tb      : std_logic_vector(N-1 downto 0);
   
	

begin
	-- Instantiate the alu module
    alu_tb: alu
    generic map (
        Nb => N
    )
    port map (
		operation   => operation_tb,
		data_in_0   => data_in_0_tb,
        data_in_1   => data_in_1_tb,
        data_out      => data_out_tb
    );
	
	-- Stimulus process
    stimulus_process: process
    begin
		
		data_in_0_tb <= "00001000";
		data_in_1_tb <= "00000001";
		
		wait for 5 ns;
		
		operation_tb <= "000";
		wait for CLK_PERIOD;
		
		
		operation_tb <= "001";
		wait for CLK_PERIOD;
		
		operation_tb <= "010";
		wait for CLK_PERIOD;
		
		operation_tb <= "011";
		wait for CLK_PERIOD;

		operation_tb <= "100";
		wait for CLK_PERIOD;

		operation_tb <= "101";
		wait for CLK_PERIOD;
		
		operation_tb <= "111";
		wait for CLK_PERIOD * 2;
		
		-- testbench overflow & underflow
		
		operation_tb <= "000";
		
		data_in_0_tb <= "01000000";
		data_in_1_tb <= "01000000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "00100000";
		data_in_1_tb <= "01100000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "01100000";
		data_in_1_tb <= "00100000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "01100000";
		data_in_1_tb <= "01100000";
		wait for CLK_PERIOD;
		
		operation_tb <= "000";
		
		data_in_0_tb <= "10000000";
		data_in_1_tb <= "10000000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "10000000";
		data_in_1_tb <= "11000000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "11000000";
		data_in_1_tb <= "10000000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "10100000";
		data_in_1_tb <= "10100000";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "01101000";
		data_in_1_tb <= "00100001";
		operation_tb <= "100";
		wait for CLK_PERIOD;
		
		data_in_0_tb <= "01101000";
		data_in_1_tb <= "00100001";
		operation_tb <= "101";
		wait for CLK_PERIOD; 
		
		data_in_0_tb <= "01101000";
		data_in_1_tb <= "00100001";
		operation_tb <= "111";
		wait for CLK_PERIOD * 2; 
		
		wait for 5 ns;
		
    end process;		
		
end alu_testbench_behavior;
