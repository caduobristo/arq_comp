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
        1 => "1001000000000011",
        2 => "1010010000000100", 
        3 => "0001010000000000", 
        4 => "0001111000000000", 
        5 => "0000111111111111",
        6 => "0000111111111111",
        7 => "0000111111111111",
        8 => "0000111111111111",
        9 => "0000111111111111",
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