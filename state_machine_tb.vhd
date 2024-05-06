library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is
end state_machine_tb;

architecture a_state_machine_tb of state_machine_tb is
    component state_machine is
        port ( clk, rst, enable : in std_logic;
               state            : out std_logic
        );
    end component;

    constant period_time             : time := 100 ns;
    signal   finished                : std_logic := '0';
    signal   clk, rst, enable, state : std_logic;

begin
    uut: state_machine port map( clk => clk,
                                 rst => rst,
                                 enable => enable,
                                 state => state);
    
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

    process
    begin
        rst <= '1';
        enable <= '1';
        wait for period_time*2;
        rst <= '0';
        wait for period_time*4;
        enable <= '0';
        wait for period_time*2;
        enable <= '1';
        wait;
    end process;

end a_state_machine_tb;