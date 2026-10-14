library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_problem3 is
    port (
        Clock        : in std_logic;
        A, B         : in unsigned(7 DOWNTO 0);
        student_id   : in unsigned(3 DOWNTO 0);
        OP           : in unsigned(15 DOWNTO 0);
        Neg          : out std_logic;
        R1           : out unsigned(3 DOWNTO 0);
        R2           : out unsigned(3 DOWNTO 0)
    );
end ALU_problem3;

architecture calculation of ALU_problem3 is
    signal reg1, reg2, result  : unsigned(7 downto 0) := (others => '0');
    signal reg4                 : unsigned(0 to 7);
    signal A_high, A_low       : unsigned(3 downto 0);
    signal student_id_high     : unsigned(3 downto 0);
begin
    -- Extract nibbles of A
    A_high <= A(7 downto 4);
    A_low  <= A(3 downto 0);

    -- student_id is already 4 bits
    student_id_high <= student_id;

    process (Clock, OP)
    begin
        if rising_edge(Clock) then
            case OP is
                WHEN "0000000000000001" =>
                    result <= A + B;

                WHEN "0000000000000010" =>
                    result <= A - B;

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

                -- Comparison: output Y/N logic in upper nibble
                WHEN "0000001000000000" =>
                    if (A_high > student_id_high) or (A_low > student_id) then
                        result <= "11110000";  -- 'Y'
                    else
                        result <= "00000000";  -- 'N'
                    end if;

                WHEN OTHERS =>
                    null;
            end case;
        end if;
    end process;

    -- Outputs
    R1 <= result(7 downto 4);
    R2 <= result(3 downto 0);

    -- Negative flag (MSB of result)
    Neg <= result(7);

end calculation;
