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
        7  => B"1001_010_0_00000010",  --LI R2, 2
        8  => B"1001_000_1_00000000",  --LI A, 0
        9  => B"1111_010_000000000",   --MOVX @R2, A
        10 => B"0111_010_1_00000000",  --MOV A, R2
        11 => B"0010_000000000010",    --ADDI A, 2
        12 => B"0111_010_0_00000000",  --MOV R2, A
        13 => B"1100_010_0101_11011",  --JNB R2.5, -5
        14 => B"1001_000_1_00000000",  --LI A, 0
        15 => B"1111_010_000000000",   --MOVX @R2, A
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