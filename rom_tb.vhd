library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end rom_tb;

architecture a_rom_tb of rom_tb is
    component rom is
        port ( clk    : in std_logic;
               adress : in unsigned(6 downto 0);
               data   : out unsigned(15 downto 0)
             );
    end component;

    constant period_time : time := 100 ns;
    signal   finished : std_logic := '0';
    signal   clk    : std_logic;
    signal   adress : unsigned(6 downto 0);
    signal   data   : unsigned(15 downto 0);
begin
    uut: ROM port map( clk => clk, 
                       adress => adress,
                       data => data);

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

    process
    begin
        adress <= to_unsigned(1, 7);
        wait for period_time;
        adress <= to_unsigned(3, 7);
        wait for period_time;
        adress <= to_unsigned(7, 7);
        wait for period_time;
        adress <= to_unsigned(9, 7);
        wait for period_time;
        adress <= to_unsigned(15, 7);
        wait for period_time;
        wait;
    end process;
    
end a_rom_tb;