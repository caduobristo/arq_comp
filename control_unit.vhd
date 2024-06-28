library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port ( clk, rst, z, carry           : in std_logic;
           state                        : in unsigned(1 downto 0);
           instr, reg_out               : in unsigned(15 downto 0);
           clk_rom, exception           : out std_logic := '0';
           mux_ula, mux_ban             : out std_logic;
           wr_en_a, wr_en_ram, wr_carry, wr_z : out std_logic;
           mux_acc                      : out std_logic_vector(1 downto 0);
           control_ula                  : out unsigned(1 downto 0);
           reg, wrt_ban                 : out unsigned(2 downto 0);
           adress, ram_adress           : out unsigned(6 downto 0);
           const                        : out unsigned(15 downto 0)
    );
end control_unit;

architecture a_control_unit of control_unit is
component adder is 
    port ( clk, rst, z, carry : in std_logic;
           state              : in unsigned(1 downto 0);
           instr, reg         : in unsigned(15 downto 0);
           clk_rom, exception : out std_logic;
           adress             : out unsigned(6 downto 0)
    );
end component;

    signal opcode       : unsigned(3 downto 0) := (others => '0');
    signal ram_adress_s : unsigned(6 downto 0) := (others => '0');
    signal clk_rom_s, exception_s : std_logic := '0';
begin

    uut_adder: adder port map( clk, rst, z, carry, state, instr, reg_out, clk_rom_s, exception_s, adress);
    opcode <= instr(15 downto 12);
    reg <= instr(11 downto 9);
    exception <= exception_s;

    ram_adress_s <= reg_out(6 downto 0) when opcode = "1000" or
                                             opcode = "1111" else
                    ram_adress_s;

    ram_adress <= ram_adress_s;

    const <= resize(instr(11 downto 0), 16) when opcode = "0010" or
                                                 opcode = "0100" else
             resize(instr(7 downto 0), 16)  when opcode = "1001" else
             resize(instr(8 downto 0), 16)  when opcode = "1010" else
             (others => '0');

    clk_rom <= '1' when (state = "00" or
                        clk_rom_s = '1') and
                        exception_s = '0' else
               '0';  
  
    mux_acc <= "00" when opcode = "0111" or 
                         opcode = "1010" else
               "01" when (opcode = "1001" and
                         instr(8) = '1') else
               "10" when opcode = "1000" else
               "11";  
    
    control_ula <= "00" when opcode = "0001" or
                             opcode = "0010" or
                             opcode = "1101" else
                   "01" when opcode = "0011" or
                             opcode = "0100" or
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
                        opcode = "1000" or
                        (opcode = "0111" and
                        instr(8) = '1') or
                        (opcode = "1001" and
                        instr(8) = '1'))) else
               '0';
    
    wr_en_ram <= '1' when state = "01" and 
                          opcode = "1111" else
                 '0';
        
    wrt_ban <= instr(11 downto 9) when state = "01" and
                                       ((opcode = "0111" and
                                       instr(8) = '0') or
                                       (opcode = "1001" and
                                       instr(8) = '0')) else
               "000";
    
    wr_carry <= '1' when opcode = "0001" or
                         opcode = "0010" or
                         opcode = "0011" or
                         opcode = "0100" or
                         opcode = "0101" or
                         opcode = "0110" or
                         opcode = "1010" else
                '0';

    wr_z <= '1' when opcode = "0001" or
                     opcode = "0010" or
                     opcode = "0011" or
                     opcode = "0100" or
                     opcode = "0101" or
                     opcode = "0110" or
                     opcode = "1010" else
            '0';

end a_control_unit;
