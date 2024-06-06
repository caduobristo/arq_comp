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
        0  => B"1100_000000000000",   --CLR A
        1  => B"1000_011_000000000",  --MOVC R3, A
        2  => B"1000_100_000000000",  --MOVC R4, A
        3  => B"0111_011_000000000",  --MOV A, R3
        4  => B"0001_100_000000000",  --ADD A, R4
        5  => B"1000_100_000000000",  --MOVC R4, A
        6  => B"0111_011_000000000",  --MOV A, R3
        7  => B"0010_000000000001",   --ADDI A, 1
        8  => B"1000_011_000000000",  --MOVC R3, A
        9  => B"1001_000000011110",   --LI A, 30
        10  => B"0011_011_000000000", --SUB A, R3
        11  => B"1101_1111000_00000", --JZ -8
        12  => B"0111_100_000000000", --MOV A, R4
        13  => B"1000_101_000000000", --MOVC R5, A
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