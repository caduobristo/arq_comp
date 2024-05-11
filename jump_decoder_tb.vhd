library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jump_decoder_tb is
end jump_decoder_tb;

architecture a_jump_decoder_tb of jump_decoder_tb is
    component top_jump_decoder is
        port (
            clk    : in std_logic;
            instr  : in unsigned(9 downto 0)
        );
    end component;

    constant LIMIT       : natural := 5; 
    constant period_time : time := 100 ns;
    signal   finished : std_logic := '0';
    signal   clk    : std_logic;
    signal   instr : unsigned(9 downto 0);

begin
    uuttop_jump_decoder: top_jump_decoder port map( clk => clk, instr => instr );

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
        -- teste base
        instr <= "1110000001";
        wait for period_time;
        instr <= "1110000011";
        wait for period_time;
        instr <= "1110000111";
        wait for period_time;
        instr <= "1110001001";
        wait for period_time;
        instr <= "1110001111";
        wait for period_time;

        -- teste opcode
        instr <= "0000000001";
        wait for period_time;

        -- loop teste
        instr <= "1110000001";

        for i in 0 to LIMIT loop
            -- Executa o loop enquanto o endereço for menor que o limite
            if instr(6 downto 0) < LIMIT then
                instr(6 downto 0) <= instr(6 downto 0) + 1;
            end if;
            wait for PERIOD_TIME;
        end loop;
        wait for PERIOD_TIME;
        wait;
    end process;
    
end a_jump_decoder_tb;