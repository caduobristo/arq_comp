library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is 
    port( clk, rst               : in std_logic;
          state                  : out unsigned(1 downto 0);
          pc                     : out unsigned(6 downto 0);
          instr                  : out unsigned(15 downto 0);
          reg1, reg2, a, ula_out : out unsigned(15 downto 0)
    );
end toplevel; 

architecture a_toplevel of toplevel is
    component reg16bits is
        port ( clk, rst, wr_en : in std_logic;
               data_in         : in unsigned(15 downto 0);
               data_out        : out unsigned(15 downto 0)
        );
    end component;

    component ban_reg is
        port ( read1, read2, wrt  : in unsigned(2 downto 0);
               data_in            : in unsigned(15 downto 0);
               clk, rst           : in std_logic;
               reg_out1, reg_out2 : out unsigned(15 downto 0)
        );
    end component;

    component ula is
        port( entrada0, entrada1 : in unsigned(15 downto 0);
              control            : in unsigned(1 downto 0);
              saida              : out unsigned(15 downto 0)
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
        port ( clk                : in std_logic;
               instr              : in unsigned(15 downto 0);
               clk_rom            : out std_logic := '0';
               mux_ula            : out std_logic;
               state, control_ula : out unsigned(1 downto 0);
               reg_ula            : out unsigned(2 downto 0);
               adress             : out unsigned(6 downto 0);
               const              : out unsigned(15 downto 0)
        );
    end component;

    signal clk_rom, mux_ula                : std_logic;
    signal control_ula                     : unsigned(1 downto 0);
    signal read1, read2, wrt               : unsigned(2 downto 0);
    signal ula_out_s, instr_s, a_s, const  : unsigned(15 downto 0);
    signal reg_out1, reg_out2, entrada_ula : unsigned(15 downto 0);
    signal adress_in, adress_out           : unsigned(6 downto 0);
   
begin
    uut_ban_reg: ban_reg port map( read1 => read1, read2 => read2, wrt => wrt, 
                                   data_in => ula_out_s, clk => clk, rst => rst,
                                   reg_out1 => reg_out1, reg_out2 => reg_out2 );

    uut_ula: ula port map( entrada0 => a_s, entrada1 => entrada_ula, 
                           control => control_ula, saida => ula_out_s );

    uut_accumulator: reg16bits port map( clk => clk, rst => rst, wr_en => '1',
                                         data_in => ula_out_s, data_out => a_s );
    
    uut_instruction: reg16bits port map( clk => clk, rst => rst, wr_en => '1',
                                         data_in => instr_s, data_out => instr );                                       

    uut_control_unit: control_unit port map ( clk => clk, instr => instr_s, clk_rom => clk_rom,
                                              mux_ula => mux_ula, state => state, 
                                              control_ula => control_ula, reg_ula => read1, 
                                              adress => adress_in, const => const );

    uut_pc: program_counter port map ( clk => clk, wr_en => '1', data_i => adress_in,
                                       data_o => adress_out );

    uut_rom: rom port map ( clk => clk_rom, adress => adress_out, data => instr_s );

    entrada_ula <= reg_out1 when mux_ula = '1' else
                   const;

    read2 <= "010";
    pc <= adress_out;
    reg1 <= reg_out1;
    reg2 <= reg_out2;
    a <= a_s;
    ula_out <= ula_out_s;

end a_toplevel;
