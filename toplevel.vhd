library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is 
    port( clk, rst   : in std_logic;
          state      : out unsigned(1 downto 0);
          pc         : out unsigned(6 downto 0);
          instr      : out unsigned(15 downto 0);
          a, ula_out : out unsigned(15 downto 0);
          reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out unsigned(15 downto 0)
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
        port ( read_in, wrt : in unsigned(2 downto 0);
               data_in      : in unsigned(15 downto 0);
               clk, rst     : in std_logic;
               read_out, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out unsigned(15 downto 0)
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
               mux_ula, mux_ban, wr_en_a : out std_logic;
               mux_acc            : out std_logic_vector(1 downto 0); 
               state, control_ula : out unsigned(1 downto 0); 
               reg_ula, wrt_ban   : out unsigned(2 downto 0);
               adress             : out unsigned(6 downto 0);
               const              : out unsigned(15 downto 0)  
        );
    end component;

    signal clk_rom, mux_ula, mux_ban, wr_en_a : std_logic;
    signal control_ula                          : unsigned(1 downto 0);
    signal mux_acc                              : std_logic_vector(1 downto 0);
    signal read_in, wrt_ban                     : unsigned(2 downto 0);
    signal ula_out_s, instr_s, a_s, const       : unsigned(15 downto 0);
    signal reg_out                              : unsigned(15 downto 0);
    signal entrada_ula, entrada_acc, entrada_ban : unsigned(15 downto 0);
    signal adress_in, adress_out                : unsigned(6 downto 0);
   
begin
    uut_ban_reg: ban_reg port map( read_in, wrt_ban, entrada_ban, clk, rst, reg_out,
                                   reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 );

    uut_ula: ula port map( entrada0 => a_s, entrada1 => entrada_ula, 
                           control => control_ula, saida => ula_out_s );

    uut_accumulator: reg16bits port map( clk => clk_rom, rst => rst, wr_en => wr_en_a,
                                         data_in => entrada_acc, data_out => a_s );
    
    uut_instruction: reg16bits port map( clk => clk, rst => rst, wr_en => '1',
                                         data_in => instr_s, data_out => instr );                                       

    uut_control_unit: control_unit port map ( clk => clk, instr => instr_s, clk_rom => clk_rom,
                                              mux_ula => mux_ula, mux_ban => mux_ban,
                                              wr_en_a => wr_en_a, mux_acc => mux_acc, 
                                              state => state, control_ula => control_ula, 
                                              reg_ula => read_in, wrt_ban => wrt_ban, 
                                              adress => adress_in, const => const );

    uut_pc: program_counter port map ( clk => clk, wr_en => '1', data_i => adress_in,
                                       data_o => adress_out );

    uut_rom: rom port map ( clk => clk_rom, adress => adress_out, data => instr_s );

    entrada_ula <= reg_out when mux_ula = '1' else
                   const;

    entrada_acc <= reg_out when mux_acc = "00" else
                   const when mux_acc = "01" else 
                   ula_out_s;
   
    entrada_ban <= const when mux_ban = '1' else
                   a_s;
    
    pc <= adress_out;
    a <= a_s;
    ula_out <= ula_out_s;

end a_toplevel;
