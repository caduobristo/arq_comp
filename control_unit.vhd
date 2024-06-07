library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk, rst, Z, carry_sum, carry_sub : in std_logic;
           state                             : in unsigned(1 downto 0);
           instr                             : in unsigned(15 downto 0);
           clk_rom                           : out std_logic := '0';
           mux_ula, mux_ban, wr_en_a         : out std_logic;
           mux_acc                           : out std_logic_vector(1 downto 0);
           control_ula                       : out unsigned(1 downto 0);
           reg_ula, wrt_ban                  : out unsigned(2 downto 0);
           adress                            : out unsigned(6 downto 0);
           const                             : out unsigned(15 downto 0)
    );
end control_unit;

architecture a_control_unit of control_unit is
component adder is 
    port ( clk, rst, Z, carry_sub : in std_logic;
           state                  : in unsigned(1 downto 0);
           instr                  : in unsigned(15 downto 0);
           clk_rom                : out std_logic;
           adress                 : out unsigned(6 downto 0)
    );
end component;

    signal opcode    : unsigned(3 downto 0);
    signal clk_rom_s : std_logic;
begin

    uut_adder: adder port map( clk, rst, Z, carry_sub, state, instr, clk_rom_s, adress);

    opcode <= instr(15 downto 12);
    reg_ula <= instr(11 downto 9);

    const <= resize(instr(11 downto 0), 16) when opcode = "0010" or
                                                 opcode = "0100" else
             resize(instr(7 downto 0), 16) when opcode = "1001" else
             resize(instr(8 downto 0), 16)  when opcode = "1010" else
             (others => '0');

    clk_rom <= '1' when state = "00" or
                        clk_rom_s = '1' else
               '0';  
  
    mux_acc <= "00" when opcode = "0111" or 
                         opcode = "1010" else
               "01" when (opcode = "1001" and
                          instr(8) = '1') or
                         opcode = "1100" else
               "10";  
    
    control_ula <= "00" when opcode = "0001" or
                             opcode = "0010" or
                             opcode = "1101" else
                   "01" when opcode = "0011" or
                             opcode = "1000" or
                             opcode = "1010" else
                   "10" when opcode = "0101" else
                   "11";  
    
    mux_ula <= '1' when opcode = "0001" or
                        opcode = "0011" or
                        opcode = "0101" or
                        opcode = "0110" else
               '0';
    
    mux_ban <= '1' when opcode = "1001" and
                        instr(8) = '0' else
               '0';
        
    wr_en_a <= '1' when opcode = "1010" or
                        (state = "01" and
                        (opcode = "0001" or
                        opcode = "0010" or
                        opcode = "0011" or
                        opcode = "0100" or
                        opcode = "0101" or
                        opcode = "0110" or
                        opcode = "1100" or
                        (opcode = "0111" and
                        instr(8) = '1') or
                        (opcode = "1001" and
                        instr(8) = '1'))) else
               '0';
        
    wrt_ban <= instr(11 downto 9) when state = "01" and
                                       ((opcode = "0111" and
                                       instr(8) = '0') or
                                       (opcode = "1001" and
                                       instr(8) = '0')) else
               "000";

end a_control_unit;
