-------------------------------------------------------------------------------
--
-- Title       : alu
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
use IEEE.numeric_std.all;

entity alu is
		generic (
		Nb : integer := 8
		);	
	 port(
	 	 operation : in STD_LOGIC_VECTOR(2 downto 0);
	 	 data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	     );
end alu;

architecture alu_behavior of alu is	 

begin   	
	
	process (data_in_0, data_in_1, operation)
	
	variable a_out, b_out : unsigned(Nb - 1 downto 0) := (others => '0');
	variable overflow : std_logic := '0';
	variable underflow : std_logic := '0';
	variable carry : std_logic := '0';
			
		begin
			
			a_out := unsigned(data_in_0);
			b_out := unsigned(data_in_1);
			
    		case operation is
      			when "000" =>	-- a + b 
				when "001" =>	-- a - b
				  	b_out := unsigned(not data_in_1) + 1;
				when "010" =>	-- - a + b
					a_out := unsigned(not data_in_0) + 1;
				when "011" =>	-- - a - b
					a_out := unsigned(not data_in_0) + 1;
					b_out := unsigned(not data_in_1) + 1;
				when "100" =>   -- ca2(a)
					a_out := unsigned(not data_in_0) + 1;
					b_out := (others => '0');
				when "101" =>   -- ca2(b)
					a_out := (others => '0');
					b_out := unsigned(not data_in_1) + 1;
      			when others =>
				  	a_out := (others => '0');
					b_out := (others => '0');
    		end case;
			
			-- Carry
			carry := '0';
			for i in 0 to Nb - 3 loop
            	if ( (a_out(i) = '1' and b_out(i) = '1') or
					 (a_out(i) = '1' and carry = '1') or 
					 (b_out(i) = '1' and carry = '1') ) then
                	carry := '1';
            	else
                	carry := '0';
            	end if;
        	end loop;
			
			-- Overflow
			overflow := '0';
			if ( (a_out(Nb-1) = '0' and a_out(Nb-2) = '1' and b_out(Nb-1) = '0' and b_out(Nb-2) = '1') or 
				 (carry = '1' and a_out(Nb-1) = '0' and b_out(Nb-1) = '0' and b_out(Nb-2) = '1') or
				 (carry = '1' and a_out(Nb-1) = '0' and a_out(Nb-2) = '1' and b_out(Nb-1) = '0') ) then
				overflow := '1';
			end if;
			
			-- Underflow
			underflow := '0';
			if ( (carry = '0' and a_out(Nb-1) = '1' and a_out(Nb-2) = '0' and b_out(Nb-1) = '1') or
				 (carry = '0' and a_out(Nb-1) = '1' and b_out(Nb-1) = '1' and b_out(Nb-2) = '0') or
				 (a_out(Nb-1) = '1' and a_out(Nb-2) = '0' and b_out(Nb-1) = '1' and b_out(Nb-2) = '0') ) then
				underflow := '1';
			end if; 
			
			if ( overflow = '1' or underflow = '1' ) then 
				data_out <= (others => '0');
			else 
				data_out <= std_logic_vector(a_out + b_out);
			end if;
			
  		end process;

end alu_behavior;
