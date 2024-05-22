library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end toplevel_tb;

architecture a_toplevel_tb of toplevel_tb is
    component toplevel is
        port( clk, rst   : in std_logic;
              state      : out unsigned(1 downto 0);
              pc         : out unsigned(6 downto 0);
              instr      : out unsigned(15 downto 0);
              a, ula_out : out unsigned(15 downto 0);
              reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';
    signal   clk, rst    : std_logic;
    signal   state       : unsigned(1 downto 0);
    signal   pc          : unsigned(6 downto 0);
    signal   instr       : unsigned(15 downto 0);
    signal   a, ula_out  : unsigned(15 downto 0);
    signal   reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : unsigned(15 downto 0);
    
begin
    uut_toplevel: toplevel port map( clk, rst, state, pc, instr, a, ula_out,
                                     reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 10 us;
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
    
end a_toplevel_tb;