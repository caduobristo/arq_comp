library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
    port ( clk, wr_en, rst : in std_logic;
           data_i          : in unsigned(6 downto 0);
           data_o          : out unsigned(6 downto 0)
    );
end entity;

architecture a_program_counter of program_counter is
    signal counter : unsigned(6 downto 0) := "0000000";
begin
    process(clk, wr_en, rst)
    begin
        if rst = '1' then
            counter <= "0000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                counter <= data_i;
            end if;
        end if;
    end process;

    data_o <= counter;
end a_program_counter;