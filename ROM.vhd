library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
  port ( clk    : in std_logic;
         adress : in unsigned(6 downto 0);
         data   : out unsigned(11 downto 0)
  ) ;
end ROM;

architecture a_ROM of ROM is
    type mem is array (0 to 127) of unsigned(11 downto 0);
    constant content_rom : mem := (
        0 => "000000000000",
        1 => "000000010000",
        2 => "000011100000",
        3 => "100000000000",
        4 => "111000001000",
        5 => "000000001000",
        6 => "010011100000",
        7 => "000000000001",
        8 => "000000000100",
        9 => "000111011000",
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= content_rom(to_integer(adress));
        end if;
    end process;
end a_ROM;