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
	
	component Mux_1x2 is
		generic (Nb : integer := 8);
		port( 
			selector : in STD_LOGIC;
			data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0); 
			data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component;
		
	signal carries : STD_LOGIC_VECTOR(Nb downto 0);
	signal s : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal overflow : STD_LOGIC := '0';
	signal underflow : STD_LOGIC := '0';
	signal zero : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal sel : STD_LOGIC := '0';
	
begin

	g1 : for k in Nb-1 downto 0 generate
        fai : FullAdder port map(a(k), b(k), carries(k), s(k), carries(k+1));
    end generate;
	
	mux : Mux_1x2 generic map (Nb => Nb) port map (sel, s, zero, sum); 
	
	carries(0) <= '0';
	sel <= overflow or underflow;
	underflow <= ( not carries(Nb-2) and a(Nb-1) and not a(Nb-2) and b(Nb-1) ) or
				 ( not carries(Nb-2) and a(Nb-1) and b(Nb-1) and not b(Nb-2) ) or
				 ( a(Nb-1) and not a(Nb-2) and b(Nb-1) and not b(Nb-2) );
	overflow <= ( not a(Nb-1) and a(Nb-2) and not b(Nb-1) and b(Nb-2) ) or 
				( carries(Nb-2) and not a(Nb-1) and not b(Nb-1) and b(Nb-2) ) or
				( carries(Nb-2) and not a(Nb-1) and a(Nb-2) and not b(Nb-1) );

end NbAdder_behavior;
