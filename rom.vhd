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
        --Carrega a ram do endereço 1 ao 32
        0  => B"1001_001_0_00000001",  --LI R1, 1
        1  => B"0111_001_1_00000000",  --MOV A, R1
        2  => B"1111_001_000000000",   --MOVX @R1, A
        3  => B"0010_000000000001",    --ADDI A, 1
        4  => B"0111_001_0_00000000",  --MOV R1, A
        5  => B"1100_001_0101_11101",  --JNB R1.5, -3
        6  => B"1111_001_000000000",   --MOVX @R1, A
        --Elimina os multiplos de 2
        7  => B"1001_010_0_00000100",  --LI R2, 4
        8  => B"1001_000_1_00000000",  --LI A, 0
        9  => B"1111_010_000000000",   --MOVX @R2, A
        10 => B"0111_010_1_00000000",  --MOV A, R2
        11 => B"0010_000000000010",    --ADDI A, 2
        12 => B"0111_010_0_00000000",  --MOV R2, A
        13 => B"1100_010_0101_11011",  --JNB R2.5, -5
        14 => B"1001_000_1_00000000",  --LI A, 0
        15 => B"1111_010_000000000",   --MOVX @R2, A
        --Elimina os multiplos de 3
        16 => B"1001_011_0_00000110",  --LI R3, 6
        17 => B"1001_000_1_00000000",  --LI A, 0
        18 => B"1111_011_000000000",   --MOVX @R3, A
        19 => B"0111_011_1_00000000",  --MOV A, R3
        20 => B"0010_000000000011",    --ADDI A, 3
        21 => B"0111_011_0_00000000",  --MOV R3, A
        22 => B"1100_011_0101_11011",  --JNB R3.5, -5
        23 => B"1001_000_1_00000000",  --LI A, 0
        24 => B"1111_011_000000000",   --MOVX @R3, A
        --Elimina os multiplos de 5
        25 => B"1001_100_0_00001010",  --LI R4, 10
        26 => B"1001_000_1_00000000",  --LI A, 0
        27 => B"1111_100_000000000",   --MOVX @R4, A
        28 => B"0111_100_1_00000000",  --MOV A, R4
        29 => B"0010_000000000101",    --ADDI A, 5
        30 => B"0111_100_0_00000000",  --MOV R4, A
        31 => B"1100_100_0101_11011",  --JNB R4.5, -5
        32 => B"1001_000_1_00000000",  --LI A, 0
        33 => B"1111_100_000000000",   --MOVX @R4, A
        --Lista a memória dos endereços 2 a 32
        34 => B"1001_101_0_00000010",  --LI R5, 2
        35 => B"1000_101_000000000",   --MOVX A, @R5
        36 => B"0111_101_1_00000000",  --MOV A, R5
        37 => B"0010_000000000001",    --ADDI A, 1
        38 => B"0111_101_0_00000000",  --MOV R5, A
        39 => B"1100_101_0101_11100",  --JNB R5.5, -4
        40 => B"1000_101_000000000",   --MOVX A, @R5
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