-------------------------------------------------------------------------------
--
-- Title       : sipo
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

entity sipo is
	generic (
		Nb : integer := 8
		);
	 port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 enable : in STD_LOGIC;
		 data_in : in STD_LOGIC;
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end sipo;

architecture sipo_behavior of sipo is

	signal data : std_logic_vector(Nb-1 downto 0);

begin
	
	process(clk, reset)
        begin
            if ( reset = '0' ) then
                data <= (others => '0');
            elsif ( rising_edge(clk) and enable = '1' ) then
                data <= data_in & data(Nb-1 downto 1);
            end if;
        end process;
    
    data_out <= data;
		
end sipo_behavior;
