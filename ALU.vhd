Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is

port ( Clock : in std_logic;
		 A, B  : in unsigned(7 DOWNTO 0);
		 student_id : in unsigned(3 DOWNTO 0);
		 OP : in unsigned(15 DOWNTO 0);
		 Neg: out std_logic;
		 R1: out unsigned(3 DOWNTO 0);
		 R2: out unsigned (3 DOWNTO 0)
);
end ALU;

architecture calculation of ALU is
signal reg1, reg2, result : unsigned(7 downto 0) := (others=>'0');
signal reg4 : unsigned (0 to 7);
begin
reg1 <= A;
reg2 <= B;
process (Clock, OP)
begin
	if (rising_edge(Clock)) THEN
		case OP is
			WHEN "0000000000000001" =>
				result <= A+B;
			
			WHEN "0000000000000010" =>
				result <= A-B;
			
			WHEN "0000000000000100" =>
				result <= NOT A;
			
			WHEN "0000000000001000" =>
				result <= A NAND B;
			
			WHEN "0000000000010000" =>
				result <= A NOR B;
			
			WHEN "0000000000100000" =>
				result <= A AND B;
			
			WHEN "0000000001000000" =>
				result <= A OR B;
			
			WHEN "0000000010000000" =>
				result <= A XOR B;
			
			WHEN "0000000100000000" =>
				result <= A XNOR B;
			
			WHEN OTHERS =>
				-- do nothing (dont care)
		end case;
	end if;
end process;
R1 <= result(3 downto 0);
R2 <= result (7 downto 4);
end calculation;


