library ieee;

use ieee.std_logic_1164.all;

entity fsm is

    port(

        clk           : in  std_logic;

        reset         : in  std_logic;                    -- active-high reset

        data_in       : in  std_logic;                    -- step control

        student_id    : out std_logic_vector(3 downto 0); -- 7-seg digit

        current_state : out std_logic_vector(3 downto 0); -- to 4×16 decoder

        comparison_result : out std_logic                  -- 'y' or 'n' based on comparison

    );

end entity;

architecture machine of fsm is

    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);  -- 9 states for 9 digits

    signal yfsm : state_type;

    signal sid  : std_logic_vector(3 downto 0);           -- internal digit

    signal A     : std_logic_vector(7 downto 0);           -- 8-bit input A

    signal A_upper, A_lower : std_logic_vector(3 downto 0); -- upper and lower digits of A

begin

    --------------------------------------------------------------------------

    -- State register / next-state logic

    --------------------------------------------------------------------------

    process(clk, reset)

    begin

        if reset = '1' then

            yfsm <= s0;  -- Reset state to s0

        elsif rising_edge(clk) then

            if data_in = '1' then  -- advance only when input = 1

                case yfsm is

                    when s0 => yfsm <= s1;

                    when s1 => yfsm <= s2;

                    when s2 => yfsm <= s3;

                    when s3 => yfsm <= s4;

                    when s4 => yfsm <= s5;

                    when s5 => yfsm <= s6;

                    when s6 => yfsm <= s7;

                    when s7 => yfsm <= s8;

                    when s8 => yfsm <= s0;  -- Loop back to s0

                end case;

            end if;

        end if;

    end process;

    --------------------------------------------------------------------------

    -- Moore Outputs (depend ONLY on state)

    --------------------------------------------------------------------------

    process(yfsm)

    begin

        case yfsm is

            when s0 =>

                current_state <= "0000";  -- state 0

                sid <= "0101";            -- 5 (digit 1)

            when s1 =>

                current_state <= "0001";  -- state 1

                sid <= "0000";            -- 0 (digit 2)

            when s2 =>

                current_state <= "0010";  -- state 2

                sid <= "0001";            -- 1 (digit 3)

            when s3 =>

                current_state <= "0011";  -- state 3

                sid <= "0011";            -- 3 (digit 4)

            when s4 =>

                current_state <= "0100";  -- state 4

                sid <= "0001";            -- 1 (digit 5)

            when s5 =>

                current_state <= "0101";  -- state 5

                sid <= "0110";            -- 6 (digit 6)

            when s6 =>

                current_state <= "0110";  -- state 6

                sid <= "1001";            -- 9 (digit 7)

            when s7 =>

                current_state <= "0111";  -- state 7

                sid <= "0010";            -- 2 (digit 8)

            when s8 =>

                current_state <= "1000";  -- state 8

                sid <= "0101";            -- 5 (digit 9)

        end case;

        -- Extract upper and lower digits of A

        A_upper <= A(7 downto 4);  -- upper 4 bits

        A_lower <= A(3 downto 0);  -- lower 4 bits

        -- Compare digits of A with student_id

        if (A_upper > sid) or (A_lower > sid) then

            comparison_result <= '1';  -- 'y' if one of A's digits is greater

        else

            comparison_result <= '0';  -- 'n' otherwise

        end if;

        -- Output student_id

        student_id <= sid;

    end process;

end architecture;