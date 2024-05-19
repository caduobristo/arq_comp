library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
    port( clk, rst, wr_en : in std_logic;
          control_mux     : in std_logic;
          control_ula     : in unsigned(1 downto 0);
          constant_in     : in unsigned(15 downto 0);
          saida           : out unsigned(15 downto 0)
    );
end toplevel;

architecture a_toplevel of toplevel is
    component ban_reg is
        port ( read1, read2, wrt  : in unsigned(2 downto 0);
               data_in            : in unsigned(15 downto 0);
               clk, rst, wr_en    : in std_logic;
               reg_out1, reg_out2 : out unsigned(15 downto 0)
        );
    end component;

    component ula is
        port( entrada0, entrada1 : in unsigned(15 downto 0);
              control            : in unsigned(1 downto 0);
              saida              : out unsigned(15 downto 0);
              negativo, carry    : out std_logic := '0'
        );
    end component;

    component rom is
        port ( clk    : in std_logic;
               adress : in unsigned(6 downto 0);
               data   : out unsigned(15 downto 0)
        );
    end component;

    component program_counter is
        port ( clk, wr_en : in std_logic;
               data_i     : in unsigned(6 downto 0);
               data_o     : out unsigned(6 downto 0)
        );

    end component;

    component control_unit is
        port ( clk      : in std_logic;
               instr    : in unsigned(15 downto 0);
               data_in  : in unsigned(6 downto 0);
               data_out : out unsigned(6 downto 0);
               clk_rom  : out std_logic
        );
    end component;

    signal negativo, carry, clk_rom                : std_logic;
    signal read1, read2, wrt                       : unsigned(2 downto 0);
    signal ula_out, reg_out1, reg_out2, mux, instr : unsigned(15 downto 0);
    signal in_control, out_control                 : unsigned(6 downto 0);
   
begin
    uut_ban_reg: ban_reg port map( read1 => read1, read2 => read2, wrt => wrt, 
                                   data_in => ula_out, clk => clk, rst => rst, wr_en => wr_en,
                                   reg_out1 => reg_out1, reg_out2 => reg_out2 );

    uut_ula: ula port map( entrada0 => reg_out1, entrada1 => mux, control => control_ula,
                           saida => ula_out, negativo => negativo, carry => carry);

    uut_control_unit: control_unit port map ( clk => clk, data_in => in_control, instr => instr, 
                                              data_out => out_control, clk_rom => clk_rom);

    uut_pc: program_counter port map ( clk => clk, wr_en => '1', data_i => out_control,
                                       data_o => in_control);

    uut_rom: rom port map ( clk => clk_rom, adress => out_control, data => instr);

    mux <= reg_out2 when control_mux = '1' else
           constant_in;

    saida <= instr;

end a_toplevel;
