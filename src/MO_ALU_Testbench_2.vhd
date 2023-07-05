-------------------------------------------------------------------------------
--
-- Title       : MO_ALU_Testbench_2
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it
-- Company     : Università degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MO_ALU_Testbench_2 is
end MO_ALU_Testbench_2;

architecture MO_ALU_Testbench_2_behavior of MO_ALU_Testbench_2 is

	-- Component declaration
	component MO_ALU is
		generic(Nb : integer := 8);
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
		 	enable : in STD_LOGIC;
		 	data_in : in STD_LOGIC;
		 	control_bit : in STD_LOGIC;
		 	operation_code : in STD_LOGIC_VECTOR(2 downto 0);
		 	result : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	    );	
	end component;
	
	-- Testbench constant
	constant N : integer := 4; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
	-- Testbench signals
	signal clk_tb : STD_LOGIC := '0';
	signal reset_tb : STD_LOGIC := '0';
	signal enable_tb : STD_LOGIC := '0';
	signal data_in_tb : STD_LOGIC := '0';
	signal control_bit_tb: STD_LOGIC := '0';
	signal operation_code_tb : STD_LOGIC_VECTOR(2 downto 0);
	signal result_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal a_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal b_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	
begin

	-- Instantiate the MO_ALU module
	MO_ALU_tb : MO_ALU generic map (Nb => N) port map (clk_tb, reset_tb, enable_tb, data_in_tb, control_bit_tb, operation_code_tb, result_tb, a_tb, b_tb);
	
	-- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
        clk_tb <= not clk_tb;
    end process;
	
	-- Reset process
    reset_process: process
    begin
		wait for CLK_PERIOD;
		reset_tb <= not reset_tb;
        wait for CLK_PERIOD * 20;
		reset_tb <= not reset_tb;
    end process;
	
	-- Enable process
    enable_process: process
    begin
        wait for CLK_PERIOD * 2;
		enable_tb <= not enable_tb;
		wait for CLK_PERIOD * 18;
		enable_tb <= not enable_tb;
    end process;
	
	-- Main process
    main_process: process
    begin
		
		wait for CLK_PERIOD;
        
		control_bit_tb <= '0';
		data_in_tb <= '0';
        wait for CLK_PERIOD * 3;
		
		control_bit_tb <= '1';
		wait for CLK_PERIOD;
		
		data_in_tb <= '0';
		wait for CLK_PERIOD;
		data_in_tb <= '1';
		control_bit_tb <= not control_bit_tb;
		wait for CLK_PERIOD;
		data_in_tb <= '0';
		wait for CLK_PERIOD;
		data_in_tb <= '1';
		wait for CLK_PERIOD; -- A = "0101" = 5
		
		data_in_tb <= '0';
		wait for CLK_PERIOD;
		control_bit_tb <= not control_bit_tb;
		data_in_tb <= '0';
		wait for CLK_PERIOD;
		control_bit_tb <= not control_bit_tb;
		data_in_tb <= '1';
		wait for CLK_PERIOD;
		data_in_tb <= '0';
		wait for CLK_PERIOD; -- B = "0010" = 2
		
		data_in_tb <= '0';
		operation_code_tb <= "010";
		wait for CLK_PERIOD * 5;
		
    end process;
	
end MO_ALU_Testbench_2_behavior;
