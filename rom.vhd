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
        0  => B"1001_011_0_00000000",  --LI R3, 0
        1  => B"1001_100_0_00000000",  --LI R4, 0
        2  => B"0111_011_1_00000000",  --MOV A, R3
        3  => B"0001_100_000000000",   --ADD A, R4
        4  => B"0111_100_0_00000000",  --MOV R4, A
        5  => B"0111_011_1_00000000",  --MOV A, R3
        6  => B"0010_000000000011",    --ADDI A, 1
        7  => B"0111_011_0_00000000",  --MOV R3, A
        8  => B"1010_011_000011110",   --CMP R3, 30
        9  => B"1101_1111001_00000",   --JZ -7
        10  => B"0111_100_1_00000000", --MOV A, R4
        11  => B"0111_101_0_00000000", --MOV R5, A 
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