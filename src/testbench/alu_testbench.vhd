-------------------------------------------------------------------------------
--
-- Title       : ALU_Testbench
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

entity ALU_Testbench is
end ALU_Testbench;

architecture ALU_Testbench_behavior of ALU_Testbench is

	-- Component declaration
    component ALU is
        generic (Nb : integer := 8);
        port(
		 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			op_a : in STD_LOGIC_VECTOR(1 downto 0);
			op_b : in STD_LOGIC_VECTOR(1 downto 0);
			r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	 	);
    end component ALU;
	
	-- Testbench constant
	constant N : integer := 8; -- Data bits
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	
    -- Testbench signals
	signal a_tb : STD_LOGIC_VECTOR(N-1 downto 0);
    signal b_tb : STD_LOGIC_VECTOR(N-1 downto 0);
	signal op_a_tb : STD_LOGIC_VECTOR(1 downto 0);
	signal op_b_tb : STD_LOGIC_VECTOR(1 downto 0);
	signal r_tb : STD_LOGIC_VECTOR(N-1 downto 0);

begin

	-- Instantiate the ALU module
    ALU_tb : ALU generic map (Nb => N) port map (a_tb, b_tb, op_a_tb, op_b_tb, r_tb);
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		a_tb <= "01010101";
		b_tb <= "00010001";
		op_a_tb <= "00";
		op_b_tb <= "00";
		wait for CLK_PERIOD;
		
		op_a_tb <= "01";
		op_b_tb <= "00";
		wait for CLK_PERIOD;
		
		op_a_tb <= "00";
		op_b_tb <= "01";
		wait for CLK_PERIOD;
		
		op_a_tb <= "01";
		op_b_tb <= "10";
		wait for CLK_PERIOD;
		
		op_a_tb <= "10";
		op_b_tb <= "01";		
		
    end process;

end ALU_Testbench_behavior;
