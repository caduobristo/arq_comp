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
        0  => B"1001_111111111111",
        1  => B"1001_000000001111",
        2  => B"1010_001_000000001", 
        3  => B"1010_010_000000010", 
        4  => B"1010_011_000000011", 
        5  => B"1010_100_000000100",
        6  => B"1010_101_000000101",
        7  => B"1010_110_000000110",
        8  => B"1010_111_000000111",
        9  => B"0111_110_111111111",
        10 => B"1000_001_111111111",
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