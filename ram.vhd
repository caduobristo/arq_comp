library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    port ( clk, wr_en : in std_logic;
           adress     : in unsigned(6 downto 0);
           data_in    : in unsigned(15 downto 0);
           data_out   : out unsigned(15 downto 0)
    );
end ram;

architecture a_ram of ram is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    signal content_ram : mem;
begin
    process(clk, wr_en)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                content_ram(to_integer(adress)) <= data_in;
            end if;
        end if;
    end process;
    data_out <= content_ram(to_integer(adress));
end a_ram;