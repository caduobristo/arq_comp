library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  port ( clk    : in std_logic;
         adress : in unsigned(6 downto 0);
         data   : out unsigned(15 downto 0)
  ) ;
end rom;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant content_rom : mem := (
        0  => B"1001_001_0_00001000", --LI R1, 8
        1  => B"1001_010_0_00100001", --LI R2, 33
        2  => B"1001_011_0_00011110", --LI R3, 30
        3  => B"1001_100_0_01110001", --LI R4, 113
        4  => B"1001_101_0_00000001", --LI R5, 1
        5  => B"1001_110_0_00001000", --LI R6, 8
        6  => B"1001_000_1_11111000", --LI A, 248
        7  => B"1111_001_000000000",  --MOVX @R1, A
        8  => B"1001_000_1_01111000", --LI A, 120 
        9  => B"1111_010_000000000",  --MOVX @R2, A
        10 => B"1001_000_1_00111000", --LI A, 56
        11 => B"1111_011_000000000",  --MOVX @R3, A
        12 => B"1001_000_1_11111111", --LI A, 255
        13 => B"1111_100_000000000",  --MOVX @R4, A
        14 => B"1001_000_1_10000000", --LI A, 128
        15 => B"1111_101_000000000",  --MOVX @R5, A
        16 => B"1000_001_000000000",  --MOVX A, @R1
        17 => B"1000_010_000000000",  --MOVX A, @R2
        18 => B"1000_011_000000000",  --MOVX A, @R3
        19 => B"1000_100_000000000",  --MOVX A, @R4
        20 => B"1000_101_000000000",  --MOVX A, @R5
        21 => B"1001_011_0_01100100", --LI R3, 100
        22 => B"1001_100_0_01010101", --LI R4, 85
        23 => B"1001_111_0_00011110", --LI R7, 30
        24 => B"1001_000_1_00011000", --LI A, 24
        25 => B"1111_011_000000000",  --MOVX @R3, A
        26 => B"1001_000_1_11100011", --LI A, 227
        27 => B"1111_100_000000000",  --MOVX @R4, A
        28 => B"1001_000_1_00000001", --LI A, 1
        29 => B"1111_111_000000000",  --MOVX @R7, A
        30 => B"1000_100_000000000",  --MOVX A, @R4
        31 => B"1000_111_000000000",  --MOVX A, @R7
        32 => B"1000_011_000000000",  --MOVX A, @R3
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= content_rom(to_integer(adress));
        end if;
    end process;
end a_rom;