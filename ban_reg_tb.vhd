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

    constant period_time               : time := 100 ns;
    signal finished                    : std_logic := '0';
    signal read1, read2, wrt           : unsigned(2 downto 0);
    signal data_in, reg_out1, reg_out2 : unsigned(15 downto 0);
    signal wr_en, rst, clk             : std_logic;

begin
    uut: ban_reg port map( read1 => read1, read2 => read2, 
                           data_in => data_in, reg_out1 => reg_out1, 
                           reg_out2 => reg_out2, wr_en => wr_en, rst => rst,
                           clk => clk);
    
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

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;

    process 
    begin
        wr_en = '1';
        read1 = "001";
        read2 = "111";
        data_in = "1111000011110000";
        wait;
    end process;
end a_ban_reg_a;