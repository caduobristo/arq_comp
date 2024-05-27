library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is
end state_machine_tb;

architecture a_state_machine_tb of state_machine_tb is
    component state_machine is
        port ( clk, rst : in std_logic;
               state    : out unsigned(1 downto 0)
        );
    end component;

    constant period_time : time := 100 ns;
    signal   finished    : std_logic := '0';
    signal   clk, rst    : std_logic;
    signal   state       : unsigned(1 downto 0);

begin
    uut: state_machine port map( clk, rst, state);
    
    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 1 us;
        finished <= '1';
        wait;
    end process;

    clk_process: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

end a_state_machine_tb;