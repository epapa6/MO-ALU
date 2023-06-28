-------------------------------------------------------------------------------
--
-- Title       : Mux_1x3
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

entity Mux_1x3 is
	generic (
		Nb : integer := 8
		);	
	 port(
	 	 selector : in STD_LOGIC_VECTOR(1 downto 0);
	 	 data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_in_2 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end Mux_1x3;

architecture Mux_1x3_behavior of Mux_1x3 is
begin

	process (data_in_0, data_in_1, data_in_2, selector)
  		begin
    		case selector is
      			when "00" =>
        			data_out <= data_in_0;
      			when "01" =>
        			data_out <= data_in_1;
      			when "10" =>
        			data_out <= data_in_2;
      			when others =>
        			data_out <= (others => '0');
    		end case;
  	end process;

end Mux_1x3_behavior;
