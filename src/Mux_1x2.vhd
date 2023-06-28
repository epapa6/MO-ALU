-------------------------------------------------------------------------------
--
-- Title       : Mux_1x2
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

entity Mux_1x2 is
	generic (Nb : integer := 8);	
	 port(
		 selector : in STD_LOGIC;
		 data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end Mux_1x2;

architecture Mux_1x2_behavior of Mux_1x2 is
begin

	process (data_in_0, data_in_1, selector)
  	begin
    	if selector = '0' then
        	data_out <= data_in_0;
      	else 
       		data_out <= data_in_1;
    	end if;
  	end process;

end Mux_1x2_behavior;
