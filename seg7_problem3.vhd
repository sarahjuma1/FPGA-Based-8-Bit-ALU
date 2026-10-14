library ieee;

use ieee.std_logic_1164.all;

entity seg7_problem3 is

    port(

        yn   : in std_logic;                -- 1 = Y, 0 = N (from comparison result)

        seg  : out std_logic_vector(6 downto 0) -- 7-seg output

    );

end entity;

architecture behavior of seg7_problem3 is

begin

    process(yn)

    begin

        if yn = '1' then

            -- Display "Y" (looks like 4 on 7-seg)

            -- ACTIVE-LOW patterns (adjust if your sseg is active-high)

            seg <= "1001100";  -- Y pattern

        else

            -- Display "N" (upside-down U)

            seg <= "0001001";  -- N pattern

        end if;

    end process;

end architecture;