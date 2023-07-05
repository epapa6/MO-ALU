-------------------------------------------------------------------------------
--
-- Title       : MO_ALU
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

entity MO_ALU is
	 generic(Nb : integer := 8);
	 port(
		 clk : in STD_LOGIC := '0';
		 reset : in STD_LOGIC := '0';
		 enable : in STD_LOGIC := '0';
		 data_in : in STD_LOGIC := '0';
		 control_bit : in STD_LOGIC := '0';
		 operation_code : in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		 result : out STD_LOGIC_VECTOR(Nb-1 downto 0);
		 a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
		 b : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	 );
end MO_ALU;

architecture MO_ALU_behavior of MO_ALU is

	component REG_IN is
		generic(Nb : integer := 8);
	 	port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
		 	din : in STD_LOGIC;
		 	enable_a : in STD_LOGIC;
		 	enable_b : in STD_LOGIC;
		 	out_a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
		 	out_b : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component;
	
	component ALU is
		generic (Nb : integer := 8);
	 	port(
		 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
		 	b : in STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
		 	op_a : in STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
		 	op_b : in STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
		 	r : out STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0')
	 	);	
	end component;
	
	component REG_OUT is
		generic (Nb : integer := 8);
		port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
		 	enable_r : in STD_LOGIC;
		 	din : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 	result : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	    );	
	end component;
	
	component CU is
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
	end component;
	
	signal en_reg_a : STD_LOGIC := '0';
	signal out_a : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal en_reg_b : STD_LOGIC := '0';
	signal out_b : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal op_a : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal op_b : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal alu_result : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal en_reg_r : STD_LOGIC := '0';
	
begin

	r_in : REG_IN generic map (Nb => Nb) port map (clk, reset, data_in, en_reg_a, en_reg_b, out_a, out_b);
	alu_op : ALU generic map (Nb => Nb) port map (out_a, out_b, op_a, op_b, alu_result);
	r_out : REG_OUT generic map (Nb => Nb) port map (clk, reset, en_reg_r, alu_result, result);
	
	fsm : CU generic map (Nb => Nb) port map (clk, reset, enable, control_bit, en_reg_a, en_reg_b, en_reg_r, operation_code, op_a, op_b);
	
	a <= out_a;
	b <= out_b;
	
end MO_ALU_behavior;
