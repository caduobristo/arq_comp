library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk      : in std_logic;
           instr    : in unsigned(15 downto 0);
           data_in  : in unsigned(6 downto 0);
           data_out : out unsigned(6 downto 0);
           clk_rom  : out std_logic := '0'
    );
end control_unit;

architecture a_control_unit of control_unit is
    component state_machine is
        port ( clk, rst, enable : in std_logic;
               state            : out std_logic
        );
    end component;
        
    signal counter : unsigned(6 downto 0) := (others => '0');
    signal state   : std_logic;
begin
    uut_state_machine: state_machine port map ( clk => clk, rst => '0', enable => '1', 
                                                state => state ); 

    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when '1' =>
                    if instr(15 downto 13) = "111" then
                        counter <= instr(6 downto 0);
                    else
                        counter <= counter + 1;
                    end if;
                    clk_rom <= '0';
                when '0' =>
                    clk_rom <= '1';
                when others =>
                    clk_rom <= '0';
            end case;     
        end if;
    end process;

    data_out <= counter;

end a_control_unit;
