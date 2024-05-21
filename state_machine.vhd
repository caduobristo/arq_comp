library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port ( clk, rst : in std_logic;
           state    : out unsigned(1 downto 0)
    );
end state_machine;

architecture a_state_machine of state_machine is
    signal state_s : unsigned(1 downto 0) := "00";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state_s <= "00";
        elsif rising_edge(clk) then
            if state_s = "01" then
                state_s <= "00";
            else
                state_s <= state_s + 1;
            end if;
        end if;
    end process;

    state <= state_s;
end a_state_machine;