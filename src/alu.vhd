-------------------------------------------------------------------------------
--
-- Title       : ALU
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

entity ALU is
	 generic (Nb : integer := 8);
	 port(
		 a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 op_a : in STD_LOGIC_VECTOR(1 downto 0);
		 op_b : in STD_LOGIC_VECTOR(1 downto 0);
		 r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	 );
end ALU;

architecture ALU_behavior of ALU is

	component TwoComplement is
        generic (Nb : integer := 8);	
		port(
		 	data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 	data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
    end component;
	
	component Mux_1x3 is
		generic (Nb : integer := 8);	
		port(
	 		selector : in STD_LOGIC_VECTOR(1 downto 0);
	 		data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_2 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
	end component;
	
	component NbAdder is
		generic (Nb : integer := 8);	
		port(
	 		a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			sum : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
	end component;
	
	signal zero : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal an : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal bn : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal a_out : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal b_out : STD_LOGIC_VECTOR(Nb-1 downto 0);
	
begin

	ca_a : TwoComplement generic map (Nb => Nb)	port map (a, an);
	ca_b : TwoComplement generic map (Nb => Nb)	port map (b, bn); 
	
	mux_a : Mux_1x3 generic map (Nb => Nb) port map (op_a, a, an, zero, a_out);
	mux_b : Mux_1x3 generic map (Nb => Nb) port map (op_b, b, bn, zero, b_out);
	
	nba : NbAdder  generic map (Nb => Nb) port map (a_out, b_out, r);
	
	

end ALU_behavior;
