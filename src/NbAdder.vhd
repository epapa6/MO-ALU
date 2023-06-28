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
	generic (Nb : integer := 8);	
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
			carry_out : out STD_LOGIC
		);
	end component;
		
	signal carries : STD_LOGIC_VECTOR(Nb downto 0);
	signal s : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal overflow : STD_LOGIC := '0';
	signal underflow : STD_LOGIC := '0';
	
begin

	g1 : for k in Nb-1 downto 0 generate
        fai : FullAdder port map(a(k), b(k), carries(k), s(k), carries(k+1));
    end generate;
	
	carries(0) <= carry_in;
	
	-- Overflow
	overflow <= '1' when ((a(Nb-1) = '0' and a(Nb-2) = '1' and b(Nb-1) = '0' and b(Nb-2) = '1') or 
						  (carries(Nb-2) = '1' and a(Nb-1) = '0' and b(Nb-1) = '0' and b(Nb-2) = '1') or
						  (carries(Nb-2) = '1' and a(Nb-1) = '0' and a(Nb-2) = '1' and b(Nb-1) = '0')) else
			    '0';
			
	-- Underflow
	underflow <= '1' when ((carries(Nb-2) = '0' and a(Nb-1) = '1' and a(Nb-2) = '0' and b(Nb-1) = '1') or
						   (carries(Nb-2) = '0' and a(Nb-1) = '1' and b(Nb-1) = '1' and b(Nb-2) = '0') or
						   (a(Nb-1) = '1' and a(Nb-2) = '0' and b(Nb-1) = '1' and b(Nb-2) = '0')) else
				 '0';
	
	sum <= (others => '0') when (overflow = '1' or underflow = '1') else
		   s;

end NbAdder_behavior;
