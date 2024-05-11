library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end control_unit_tb;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit is
        port ( clk      : in std_logic;
               data_in  : in unsigned(6 downto 0);
               data_out : out unsigned(6 downto 0);
               clk_rom  : out std_logic;
               state    : in std_logic
        );
    end component;
    
    component program_counter is
        port ( clk, wr_en : in std_logic;
               data_i     : in unsigned(6 downto 0);
               data_o     : out unsigned(6 downto 0)
        );
    end component;

    component ROM is
        port ( clk                 : in std_logic;
               adress              : in unsigned(6 downto 0);
               data                : out unsigned(11 downto 0)
        );
      end component;
    
    signal data           : unsigned(11 downto 0);
    signal in_control, out_control, data_o : unsigned(6 downto 0);
    signal clk, clk_rom, state : std_logic;
    signal data_in, data_out : unsigned(6 downto 0);
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal counter : unsigned(2 downto 0) := (others => '0');
    
begin
    m_control_unit: control_unit port map (clk => clk, data_in => in_control, data_out => out_control, clk_rom => clk_rom, state => state);
    m_program_counter: program_counter port map (clk => clk, wr_en => '1', data_i => out_control, data_o => in_control);
    m_ROM: ROM port map (clk => clk_rom, adress => out_control, data => data);
 
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
            counter <= counter + 1;
        end loop;
        wait;
    end process;

    state_proc: process (clk)
    begin
        if counter < 1 then
            state <= '0';
        else
            state <= '1';
            counter <= to_unsigned(0, counter'length);
        end if;
    end process;
    
end a_control_unit_tb;
