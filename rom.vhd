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
        0 => "0000111111111111",
        1 => "0001111111111111",
        2 => "1110111110000101",
        3 => "0011111111111111",
        4 => "0100111111111111",
        5 => "0101111111111111",
        6 => "1110111110001100",
        7 => "0111111111111111",
        8 => "1110111110001010",
        9 => "1001111111111111",
        10 => "1010111111111111",
        11 => "1011111111111111",
        12 => "1110111110000101",
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