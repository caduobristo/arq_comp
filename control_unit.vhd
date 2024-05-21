library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk                : in std_logic;
           instr              : in unsigned(15 downto 0);
           clk_rom            : out std_logic := '0';
           mux_ula            : out std_logic;
           state, control_ula : out unsigned(1 downto 0);
           reg_ula            : out unsigned(2 downto 0);
           adress             : out unsigned(6 downto 0);
           const              : out unsigned(15 downto 0)
    );
end control_unit;

architecture a_control_unit of control_unit is
    component state_machine is
        port ( clk, rst : in std_logic;
               state    : out unsigned(1 downto 0)
        );
    end component;
        
    signal adress_s : unsigned(6 downto 0) := (others => '0');
    signal state_s : unsigned(1 downto 0);
begin
    uut_state_machine: state_machine port map ( clk => clk, rst => '0', 
                                                state => state_s ); 

    process(clk)
    begin
        if rising_edge(clk) then
            case state_s is
                when "00" =>
                    adress_s <= adress_s + 1;
                    clk_rom <= '0';
                when "01" =>
                    clk_rom <= '1';
                    case instr(15 downto 12) is
                        when "0001" =>
                            control_ula <= "00";
                            mux_ula <= '1';
                            reg_ula <= instr(11 downto 9);
                        when "0010" =>
                            control_ula <= "00";
                            mux_ula <= '0';
                            const <= resize(instr(11 downto 0), 16);
                        when "1011" =>
                            adress_s <= instr(11 downto 5);
                        when others =>
                            adress_s <= adress_s;
                    end case;
                when others =>
                    clk_rom <= '0';
            end case;     
        end if;
    end process;

    adress <= adress_s;
    state <= state_s;

end a_control_unit;
