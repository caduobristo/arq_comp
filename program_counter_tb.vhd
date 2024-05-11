library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end program_counter_tb;

architecture a_program_counter_tb of program_counter_tb is
    component toplevel_pc is
        port ( clk : in std_logic);
    end component;

    constant period_time : time := 100 ns;
    signal   finished    : std_logic := '0';
    signal   clk         : std_logic;
begin
    uut: toplevel_pc port map( clk => clk );

    sim_time_proc: process
    begin
        wait for 1 us;
        finished <= '1';
        wait;
    end process;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

end a_program_counter_tb;