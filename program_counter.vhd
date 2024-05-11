library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
    port ( clk, wr_en : in std_logic;
           data_i     : in unsigned(6 downto 0);
           data_o     : out unsigned(6 downto 0)
    );
end entity;

architecture a_program_counter of program_counter is
    signal counter : unsigned(6 downto 0) := "0000000";
begin
    process(clk, wr_en)
    begin
        if wr_en = '1' then
            if rising_edge(clk) then
                counter <= data_i;
            end if;
        end if;
    end process;

    data_o <= counter;
end a_program_counter;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_pc is
    port( clk : in std_logic);
end toplevel_pc;

architecture a_toplevel_pc of toplevel_pc is
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
    signal clk_rom, state : std_logic;
    signal in_control, out_control, data_o : unsigned(6 downto 0);
    
begin
    m_control_unit: control_unit port map (clk => clk, data_in => in_control, data_out => out_control, clk_rom => clk_rom, state => state);
    m_program_counter: program_counter port map (clk => clk, wr_en => '1', data_i => out_control, data_o => in_control);
    m_ROM: ROM port map (clk => clk_rom, adress => out_control, data => data);
end a_toplevel_pc;