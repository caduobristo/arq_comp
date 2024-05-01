library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ban_reg_tb is
end ban_reg_tb;

architecture a_ban_reg_a of ban_reg_tb is
    component ban_reg is
        port ( read1, read2, wrt  : in unsigned(2 downto 0);
               data_in            : in unsigned(15 downto 0);
               wr_en, rst, clk    : in std_logic;
               reg_out1, reg_out2 : out unsigned(15 downto 0)
        );
    end component;

    constant period_time                 : time := 100 ns;
    signal   finished                    : std_logic := '0';
    signal   read1, read2, wrt           : unsigned(2 downto 0);
    signal   data_in, reg_out1, reg_out2 : unsigned(15 downto 0);
    signal   wr_en, rst, clk             : std_logic;

begin
    uut: ban_reg port map( read1 => read1, read2 => read2, data_in => data_in,
                           reg_out1 => reg_out1, reg_out2 => reg_out2, 
                           wrt => wrt, wr_en => wr_en, rst => rst, clk => clk);

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
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wrt <= "001";
        read1 <= "001";
        read2 <= "101";
        data_in <= "1111000011110000";
        wait for period_time;
        wrt <= "101";
        data_in <= "1010110100011000";
        wait for period_time;
        wrt <= "100";
        read2 <= "011";
        wait for period_time;
        wrt <= "011";
        data_in <= "0000000000000011";
        wait for period_time;
        wrt <= "000";
        wait for period_time;
        read1 <= "101";
        data_in <= "0000111100001111";
        wait for period_time;
        read2 <= "100";
        data_in <= "1111111100000001";
        wait for period_time;
        wrt <= "111";
        wait for period_time;
        rst <= '1';
        wait;
    end process;
end a_ban_reg_a;