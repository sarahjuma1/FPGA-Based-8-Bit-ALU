library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU_problem2 is
    port (
        Clock : in std_logic;
        A, B : in unsigned(7 DOWNTO 0);
        student_id : in unsigned(3 DOWNTO 0);
        OP : in unsigned(15 DOWNTO 0);
        Neg : out std_logic;
        R1 : out unsigned(3 DOWNTO 0);
        R2 : out unsigned(3 DOWNTO 0)
    );
end ALU_problem2;

architecture calculation of ALU_problem2 is
    signal reg1, reg2, result : unsigned(7 downto 0) := (others => '0');
    signal reg4 : unsigned (0 to 7);
begin
    reg1 <= A;
    reg2 <= B;

    process (Clock, OP)
    begin
        if (rising_edge(Clock)) then
            case OP is
                WHEN "0000000000000001" =>  -- Decrement B by 9
                    result <= reg2 - 9;

                WHEN "0000000000000010" =>  -- Swap the lower and upper 4 bits of B
                    result <= (reg2(3 downto 0) & reg2(7 downto 4));

                WHEN "0000000000000100" =>  -- Shift A to left by 2 bits (SHL)
                    result <= reg1(5 downto 0) & "00";  -- Left shift by 2 (fill with 0s)

                WHEN "0000000000001000" =>  -- Produce the result of NANDing A and B
                    result <= NOT (reg1 AND reg2);

                WHEN "0000000000010000" =>  -- Find the greater value of A and B (Max(A, B))
                    if reg1 > reg2 then
                        result <= reg1;
                    else
                        result <= reg2;
                    end if;

                WHEN "0000000000100000" =>  -- Invert the even bits of B
                    reg4(0) <= reg2(0);
                    reg4(1) <= NOT(reg2(1));  -- Inverting even bits
                    reg4(2) <= reg2(2);
                    reg4(3) <= NOT(reg2(3));
                    reg4(4) <= reg2(4);
                    reg4(5) <= NOT(reg2(5));
                    reg4(6) <= reg2(6);
                    reg4(7) <= NOT(reg2(7));
                    result <= reg4;

                WHEN "0000000001000000" =>  -- Produce null on the output
                    result <= (others => '0');

                WHEN "0000000010000000" =>  -- Replace the upper four bits of B with upper four bits of A
                    result <= (reg1(7 downto 4) & reg2(3 downto 0));

                WHEN "0000000100000000" =>  -- Show A on the output
                    result <= reg1;

                WHEN OTHERS =>  -- Default: Do nothing (don't care)
                    result <= (others => '0');
            end case;
        end if;
    end process;

    -- Output the lower 4 bits of the result to R1 and the upper 4 bits to R2
    R1 <= result(3 downto 0);
    R2 <= result(7 downto 4);
end calculation;
