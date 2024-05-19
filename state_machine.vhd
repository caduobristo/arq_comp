library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port ( clk, rst, enable : in std_logic;
           state            : out std_logic
    );
end state_machine;

architecture a_state_machine of state_machine is
    signal state_s : std_logic := '0';
begin
    process(clk, rst, enable)
    begin
        if rst = '1' then
            state_s <= '0';
        elsif enable = '1' then
            if rising_edge(clk) then
                state_s<= not state_s;
            end if;
        end if;
    end process;

    state <= state_s;
end a_state_machine;