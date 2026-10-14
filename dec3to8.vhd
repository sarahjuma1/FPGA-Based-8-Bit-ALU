LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dec3to8 IS
    PORT(
        w  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        En : IN  STD_LOGIC;
        y  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END dec3to8;

ARCHITECTURE Behavioral OF dec3to8 IS
    SIGNAL Enw : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    Enw <= En & w;

    WITH Enw SELECT
        y <= "00000001" WHEN "1000",
             "00000010" WHEN "1001",
             "00000100" WHEN "1010",
             "00001000" WHEN "1011",
             "00010000" WHEN "1100",
             "00100000" WHEN "1101",
             "01000000" WHEN "1110",
             "10000000" WHEN "1111",
             "00000000" WHEN OTHERS;  -- default all 0

END Behavioral;