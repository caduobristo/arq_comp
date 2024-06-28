library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit is
    port( clk, rst, wr_en, data_in : in std_logic;
          data_out                 : out std_logic
    );
end entity;

architecture a_reg1bit of reg1bit is
    signal registro : std_logic := '0';
begin

    process(clk, rst, wr_en)
    begin
        if rst = '1' then
            registro <= '0';
        elsif wr_en = '1' then
            if rising_edge(clk) then
                registro <= data_in;
            end if;
        end if;
    end process;

    data_out <= registro;
end a_reg1bit;