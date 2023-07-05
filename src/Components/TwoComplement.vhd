-------------------------------------------------------------------------------
--
-- Title       : TwoComplement
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it & d.gargaro@campus.unimib.it
-- Company     : Universita' degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------.

library IEEE;
use IEEE.std_logic_1164.all;

entity TwoComplement is
	generic (Nb : integer := 8);	
	port(
		 data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0')
	);
end TwoComplement;

architecture TwoComplement_behavior of TwoComplement is

	component NbAdder is
    	generic (Nb : integer := 8);
    	port (
      		a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			sum : out STD_LOGIC_VECTOR(Nb-1 downto 0)
    	);
  	end component NbAdder;
  
  	signal ndata_in : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal one : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');

begin
   
	ca : NbAdder generic map (Nb => Nb) port map (ndata_in, one, data_out);
	
	ndata_in <= not data_in;
	one(0) <= '1';

end TwoComplement_behavior;