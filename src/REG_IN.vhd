-------------------------------------------------------------------------------
--
-- Title       : REG_IN
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

entity REG_IN is
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
end REG_IN;

architecture REG_IN_behavior of REG_IN is

	component SIPO is
		generic(Nb : integer := 8);	
		port(
	 		clk : in STD_LOGIC;
	 		reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component;
	
begin
	
	sipo_a : SIPO generic map (Nb => Nb) port map (clk, reset, enable_a, din, out_a);
	sipo_b : SIPO generic map (Nb => Nb) port map (clk, reset, enable_b, din, out_b);

end REG_IN_behavior;
