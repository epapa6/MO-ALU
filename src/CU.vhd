-------------------------------------------------------------------------------
--
-- Title       : CU
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

entity CU is
	generic (Nb : integer := 8);
	port(
		clk : in STD_LOGIC := '0';
		reset : in STD_LOGIC := '0';
		enable : in STD_LOGIC := '0';
		control_bit : in STD_LOGIC := '0';
		enable_a : out STD_LOGIC := '0';
		enable_b : out STD_LOGIC := '0';
		enable_r : out STD_LOGIC := '0';
		operation_code : in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		operation_a : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
		operation_b : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0')
	);
end CU;

architecture CU_behavior of CU is

	component CU_REG_IN is
	 	port(
	 	 	clk : in STD_LOGIC;
	 	 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	control_bit : in STD_LOGIC;
		 	count_a : in STD_LOGIC;
		 	count_b : in STD_LOGIC;
		 	enable_a : out STD_LOGIC;
		 	enable_b : out STD_LOGIC;
		 	reset_counter : out STD_LOGIC;
		 	read_complete : out STD_LOGIC;
		 	state : out STD_LOGIC_VECTOR(4 downto 0) 
	 	);
	end component CU_REG_IN;
	
	component CU_ALU is
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	operation_code : in STD_LOGIC_VECTOR(2 downto 0);
		 	read_complete : in STD_LOGIC;
		 	write_complete : in STD_LOGIC;
		 	operation_a : out STD_LOGIC_VECTOR(1 downto 0);
		 	operation_b : out STD_LOGIC_VECTOR(1 downto 0);
		 	operation_complete : out STD_LOGIC;
		 	state : out STD_LOGIC_VECTOR(4 downto 0)
	    );
	end component CU_ALU;
	
	component CU_REG_OUT is
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
		 	operation_complete : in STD_LOGIC;
		 	enable_r : out STD_LOGIC;
		 	write_complete : out STD_LOGIC;
		 	state : out STD_LOGIC_VECTOR(4 downto 0)
	 	);
	end component CU_REG_OUT;
	
	component NbCounter is
	 	generic(Nb : integer := 8);
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
		 	enable : in STD_LOGIC;
		 	output : out STD_LOGIC
	 	);
	end component NbCounter;
	
	signal enable_reg_a : STD_LOGIC := '0';
	signal out_a : STD_LOGIC := '0';
	signal en_reg_b : STD_LOGIC := '0';
	signal out_b : STD_LOGIC := '0';
	signal reset_count : STD_LOGIC := '0';
	signal data_read : STD_LOGIC := '0';
	signal data_wrote : STD_LOGIC := '0';
	signal op_completed : STD_LOGIC := '0';
	signal state_reg_in : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal state_alu : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal state_reg_out : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	
begin

	counter_a : NbCounter generic map (Nb => Nb) port map (clk, reset_count, enable_reg_a, out_a); 
	counter_b : NbCounter generic map (Nb => Nb) port map (clk, reset_count, en_reg_b, out_b); 
	
	reg_in : CU_REG_IN port map (clk, reset, enable, control_bit, out_a, out_b, enable_reg_a, en_reg_b, reset_count, data_read, state_reg_in);
	alu : CU_ALU port map (clk, reset, enable, operation_code, data_read, data_wrote, operation_a, operation_b, op_completed, state_alu);
	reg_out : CU_REG_OUT port map (clk, reset, enable, op_completed, enable_r, data_wrote, state_reg_out);
	
	enable_a <= enable_reg_a;
	enable_b <= en_reg_b;
	
end CU_behavior;
