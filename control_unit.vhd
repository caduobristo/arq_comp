library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk, rst                  : in std_logic;
           instr                     : in unsigned(15 downto 0);
           clk_rom                   : out std_logic := '0';
           mux_ula, mux_ban, wr_en_a : out std_logic;
           mux_acc                   : out std_logic_vector(1 downto 0);
           state, control_ula        : out unsigned(1 downto 0);
           reg_ula, wrt_ban          : out unsigned(2 downto 0);
           adress                    : out unsigned(6 downto 0);
           const                     : out unsigned(15 downto 0)
    );
end control_unit;

architecture a_control_unit of control_unit is
    component state_machine is
        port ( clk, rst : in std_logic;
               state    : out unsigned(1 downto 0)
        );
    end component;
        
    signal adress_s : unsigned(6 downto 0) := (others => '0');
    signal state_s  : unsigned(1 downto 0);
    signal opcode   : unsigned(3 downto 0);
begin
    uut_state_machine: state_machine port map ( clk, rst, state_s ); 

    opcode <= instr(15 downto 12);
    process(clk)
    begin
        if rising_edge(clk) and rst /= '1' then
            case opcode is
                when "1000" =>
                    wr_en_a <= '0';
                when "1010" =>
                    wr_en_a <= '0';
                when others =>
                    wrt_ban <= "000";
                    wr_en_a <= '1';
            end case;
            case state_s is
                when "00" =>
                    case opcode is
                        when "1011" =>
                            adress_s <= adress_s;
                        when others =>
                            adress_s <= adress_s + 1;
                    end case;
                    clk_rom <= '1';
                when "01" =>
                    clk_rom <= '0';
                    case opcode is
                        when "0001" =>
                            mux_acc <= "10";
                            control_ula <= "00";
                            mux_ula <= '1';
                            reg_ula <= instr(11 downto 9);
                        when "0010" =>
                            mux_acc <= "10";
                            control_ula <= "00";
                            mux_ula <= '0';
                            const <= resize(instr(11 downto 0), 16);
                        when "0011" =>
                            mux_acc <= "10";
                            control_ula <= "01";
                            mux_ula <= '1';
                            reg_ula <= instr(11 downto 9);
                        when "0100" => 
                            mux_acc <= "10";
                            control_ula <= "01";   
                            mux_ula <= '0';
                            const <= resize(instr(11 downto 0), 16); 
                        when "0101" =>
                            mux_acc <= "10";
                            control_ula <= "10";
                            mux_ula <= '1';
                            reg_ula <= instr(11 downto 9);
                        when "0110" =>
                            mux_acc <= "10";
                            control_ula <= "11";
                            mux_ula <= '1';
                            reg_ula <= instr(11 downto 9);
                        when "0111" =>
                            mux_acc <= "00";
                            reg_ula <= instr(11 downto 9);
                        when "1000" =>
                            mux_ban <= '0';
                            wrt_ban <= instr(11 downto 9);
                        when "1001" =>
                            mux_acc <= "01";
                            const <= resize(instr(11 downto 0), 16);
                        when "1010" => 
                            mux_ban <= '1';
                            const <= resize(instr(8 downto 0), 16);
                            wrt_ban <= instr(11 downto 9);
                        when "1011" =>
                            adress_s <= instr(11 downto 5);
                        when "1100" =>
                            mux_acc <= "01";
                            const <= "0000000000000000";
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
