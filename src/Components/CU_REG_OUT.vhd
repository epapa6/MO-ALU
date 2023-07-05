-------------------------------------------------------------------------------
--
-- Title       : CU_REG_OUT
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

entity CU_REG_OUT is
	 port(
		 clk : in STD_LOGIC := '0';
		 reset : in STD_LOGIC := '0';
		 enable : in STD_LOGIC := '0';
		 operation_complete : in STD_LOGIC := '0';
		 enable_r : out STD_LOGIC := '0';
		 write_complete : out STD_LOGIC := '0';
		 state : out STD_LOGIC_VECTOR(4 downto 0) := (others => '0')
	 );
end CU_REG_OUT;

architecture CU_REG_OUT_behavior of CU_REG_OUT is

	type statetype is (STANDBY, WRITE_R, DONE); 
	signal currentstate, nextstate : statetype;

begin 
	
	cu_main : process(operation_complete, currentstate)
	
		variable output : STD_LOGIC_VECTOR(1 downto 0);
		variable state_output : STD_LOGIC_VECTOR(4 downto 0);
	
	begin
		
		case currentstate is
			when STANDBY =>	output := "00"; state_output := "10000";
				case operation_complete is
					when '1' => nextstate <= WRITE_R;
					when others => nextstate <= STANDBY;
				end case;
			when WRITE_R => output := "10";	state_output := "10001";
				nextstate <= DONE;
			when DONE => output := "01"; state_output := "10010";
				nextstate <= STANDBY;
		end case;
		
		enable_r <= output(1);
		write_complete <= output(0);
		state <= state_output;
		
	end process;
	
	cu_reset : process(clk, reset)
	begin
		if reset='0' then
   			currentstate <= STANDBY;
   		elsif rising_edge(clk) and enable = '1' then
            currentstate <= nextstate;
		end if;
	end process;

end CU_REG_OUT_behavior;
