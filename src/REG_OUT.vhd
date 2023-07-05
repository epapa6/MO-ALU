-------------------------------------------------------------------------------
--
-- Title       : REG_OUT
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

entity REG_OUT is
	 generic (Nb : integer := 8);
	 port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 enable_r : in STD_LOGIC;
		 din : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 result : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end REG_OUT;

architecture REG_OUT_behavior of REG_OUT is

	component PIPO is
		generic(Nb : integer := 8);	
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component;

begin

	pipo_r : PIPO generic map (Nb => Nb) port map (clk, reset, enable_r, din, result);

end REG_OUT_behavior;
