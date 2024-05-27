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
        0  => B"1010_011_000000101", --LIC R3, 5
        1  => B"1010_100_000001000", --LIC R4, 8
        2  => B"0111_011_000000000", --MOV A, R3
        3  => B"0001_100_000000000", --ADD A, R4
        4  => B"1000_101_000000000", --MOVC R5, A
        5  => B"0100_000000000001",  --SUBI A, 1
        6  => B"1000_101_000000000", --MOVC R5, A
        7  => B"1011_0010100_00000", --JMP 0x0010100
        8  => B"1100_000000000000",  --CLR A
        9  => B"1000_101_000000000", --MOVC R5, A

        20 => B"0111_101_000000000", --MOV A, R5
        21 => B"1000_011_000000000", --MOVC R3, A
        22 => B"1011_0000010_00000", --JMP 0x0000010
        23 => B"1100_000000000000",  --CLR A
        24 => B"1000_011_000000000", --MOVC R3, A
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