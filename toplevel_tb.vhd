library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end toplevel_tb;

architecture a_toplevel_tb of toplevel_tb is
    component toplevel is
        port( clk, rst, wr_en : in std_logic;
              control_mux     : in std_logic;
              control_ula     : in unsigned(1 downto 0);
              constant_in     : in unsigned(15 downto 0);
              saida           : out unsigned(15 downto 0)
        );
    end component;

    constant period_time                     : time      := 100 ns;
    signal   finished                        : std_logic := '0';
    signal   clk, rst, wr_en, control_mux    : std_logic;
    signal   saida                           : unsigned(15 downto 0);
    signal   reg_out1, reg_out2, constant_in : unsigned(15 downto 0);
    
begin
    uut_toplevel: toplevel port map( clk => clk, rst => rst, wr_en => wr_en,
                                     control_ula => "00", control_mux => control_mux, 
                                     constant_in => constant_in, saida => saida);

    reset_global: process
    begin
        rst <= '1';
        wait for period_time;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 3 us;
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