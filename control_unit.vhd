library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk      : in std_logic;
           data_in  : in unsigned(6 downto 0);
           data_out : out unsigned(6 downto 0)
    );
end control_unit;

architecture a_control_unit of control_unit is
    signal counter: unsigned(6 downto 0) := "0000000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= to_unsigned(to_integer(data_in) + 1, 7);
        end if;
    end process;

    data_out <= counter;
end a_control_unit;