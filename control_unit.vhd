library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk, state           : in std_logic;
           data_in              : in unsigned(6 downto 0);
           data_out             : out unsigned(6 downto 0);
           clk_rom              : out std_logic
    );
end control_unit;

architecture a_control_unit of control_unit is
    signal counter: unsigned(6 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when '1' =>
                    counter <= counter + 1;
                    clk_rom <= '0';
                when '0' =>
                    clk_rom <= '1';
                when others =>
                    clk_rom <= '0';
            end case;     
        end if;
    end process;

    data_out <= counter;

end a_control_unit;
