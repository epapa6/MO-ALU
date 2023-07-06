-------------------------------------------------------------------------------
--
-- Title       : NbCounter
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
use ieee.numeric_std.all;

entity NbCounter is
	generic(Nb : integer := 8);
	port(
		clk : in STD_LOGIC := '0';
		reset : in STD_LOGIC := '0';
		enable : in STD_LOGIC := '0';
		output : out STD_LOGIC := '0'
	);
end NbCounter;	

architecture NbCounter_behavior of NbCounter is	

	signal count : integer := 0;	

begin

	process (clk, reset)
	begin 
		if reset = '0' then
			count <= 0;
		elsif (rising_edge(clk) and enable = '1') then 
			if (count = Nb - 2) then
				count <= 0;
				output <= '1';
			else
				count <= count + 1;
				output <= '0';
			end if;
		end if;
	end process;
			
end NbCounter_behavior;