-------------------------------------------------------------------------------
--
-- Title       : CU_ALU
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

entity CU_ALU is
	port(
		clk : in STD_LOGIC := '0';
		reset : in STD_LOGIC := '0';
		enable : in STD_LOGIC := '0';
		operation_code : in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		read_complete : in STD_LOGIC := '0';
		write_complete : in STD_LOGIC := '0';
		operation_a : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
		operation_b : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
		operation_complete : out STD_LOGIC := '0';
		state : out STD_LOGIC_VECTOR(4 downto 0) := (others => '0')
	);
end CU_ALU;

architecture CU_ALU_behavior of CU_ALU is

	type statetype is (STANDBY, OPERATION, A_PLUS_B, A_MINUS_B, B_MINUS_A, CA2_A, CA2_B, A_PLUS_B_DONE, A_MINUS_B_DONE, B_MINUS_A_DONE, CA2_A_DONE, CA2_B_DONE); 
	signal currentstate, nextstate : statetype;

begin
	
	cu_main : process(operation_code, read_complete, write_complete, currentstate)
	
	variable output : STD_LOGIC_VECTOR(4 downto 0);
	variable state_output : STD_LOGIC_VECTOR(4 downto 0);
	
	begin

		case currentstate is
			when STANDBY =>	output := "00000"; state_output := "01000";
				case read_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= STANDBY;
				end case;
			when OPERATION => output := "00000"; state_output := "01001";
				case operation_code is
					when "000" => nextstate <= A_PLUS_B;
					when "001" => nextstate <= A_MINUS_B;
					when "010" => nextstate <= B_MINUS_A;
					when "101" => nextstate <= CA2_B;
					when "110" => nextstate <= CA2_A;
					when others => nextstate <= OPERATION;
				end case;
			when A_PLUS_B => output := "00000";	state_output := "01010";
				nextstate <= A_PLUS_B_DONE;
			when A_MINUS_B => output := "00010"; state_output := "01011";
				nextstate <= A_MINUS_B_DONE;
			when B_MINUS_A => output := "01000"; state_output := "01100";
				nextstate <= B_MINUS_A_DONE;
			when CA2_A => output := "01100"; state_output := "01101";
				nextstate <= CA2_A_DONE;
			when CA2_B => output := "10010"; state_output := "01110";
				nextstate <= CA2_B_DONE;
			when A_PLUS_B_DONE => output := "00001"; state_output := "01111";
				case write_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= A_PLUS_B_DONE;
				end case;
			when A_MINUS_B_DONE => output := "00011"; state_output := "01111";
				case write_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= A_MINUS_B_DONE;
				end case;
			when B_MINUS_A_DONE => output := "01001"; state_output := "01111";
				case write_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= B_MINUS_A_DONE;
				end case;
			when CA2_A_DONE => output := "01101"; state_output := "01111";
				case write_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= CA2_A_DONE;
				end case;
			when CA2_B_DONE => output := "10011"; state_output := "01111";
				case write_complete is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= CA2_B_DONE;
				end case;
		end case;

		operation_a <= output(4) & output(3);
		operation_b <= output(2) & output(1);
		operation_complete <= output(0);
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

end CU_ALU_behavior;
