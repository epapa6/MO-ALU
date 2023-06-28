-------------------------------------------------------------------------------
--
-- Title       : NbAdder
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

entity NbAdder is
	generic (
		Nb : integer := 8
		);	
	 port(
	 	 a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
	 	 carry_in : in STD_LOGIC;
		 sum : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end NbAdder;

architecture NbAdder_behavior of NbAdder is

	component FullAdder is
		port( 
			a : in STD_LOGIC; 
			b : in STD_LOGIC;
			carry_in : in STD_LOGIC;
    		sum : out STD_LOGIC; 
			carry_out :out STD_LOGIC
			);
	end component;
		
	signal carries: STD_LOGIC_VECTOR(Nb downto 0);	
	
	begin

	g1 : for k in Nb-1 downto 0 generate
         fai : FullAdder port map(a(k), b(k), carries(k), sum(k), carries(k+1));
         end generate;

	carries(0) <= carry_in;

end NbAdder_behavior;
