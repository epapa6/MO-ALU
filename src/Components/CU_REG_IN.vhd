-------------------------------------------------------------------------------
--
-- Title       : CU_REG_IN
-- Design      : MOALU
-- Author      : e.papa6@campus.unimib.it
-- Company     : Università degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CU_REG_IN is
	 port(
	 	 clk : in STD_LOGIC := '0';
	 	 reset : in STD_LOGIC := '0';
		 enable : in STD_LOGIC := '0';
		 control_bit : in STD_LOGIC := '0';
		 count_a : in STD_LOGIC := '0';
		 count_b : in STD_LOGIC := '0';
		 enable_a : out STD_LOGIC := '0';
		 enable_b : out STD_LOGIC := '0';
		 reset_counter : out STD_LOGIC := '0';
		 read_complete : out STD_LOGIC := '0';
		 state : out STD_LOGIC_VECTOR(4 downto 0) := (others => '0') 
	 );
end CU_REG_IN;

architecture CU_REG_IN_behavior of CU_REG_IN is

	type statetype is (STANDBY, READ_A, READ_B, DONE); 
	signal currentstate, nextstate : statetype;

begin 
	
	cu_main : process(count_b, count_a, control_bit, currentstate)
	
		variable output : STD_LOGIC_VECTOR(3 downto 0);
		variable state_output : STD_LOGIC_VECTOR (4 downto 0);
	
	begin
		
		case currentstate is
			when STANDBY =>	output := "0000"; state_output := "00000";
				case control_bit is
					when '1' => nextstate <= READ_A;
					when others => nextstate <= STANDBY;
				end case;
			when READ_A => output := "1010"; state_output := "00001";
				case count_a is 
					when '1' => nextstate <= READ_B;
					when others => nextstate <= READ_A;
				end case;
			when READ_B => output := "0110"; state_output := "00010";
				case count_b is
					when '1' => nextstate <= DONE;
					when others => nextstate <= READ_B;	
				end case;
			when DONE => output := "0011"; state_output := "00011";
				nextstate <= DONE;		
		end case;
			
		enable_a <= output(3);
		enable_b <= output(2);
		reset_counter <= output(1);
		read_complete <= output(0);
		state <= state_output;
		
	end process;
	
	cu_reset : process(clk, reset, enable)
	begin
		if reset='0' then
   			currentstate <= STANDBY;
   		elsif rising_edge(clk) and enable = '1' then
            currentstate <= nextstate;
		end if;
	end process;
	

end CU_REG_IN_behavior;
