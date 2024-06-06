library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is 
    port( clk, rst   : in std_logic;
          state      : out unsigned(1 downto 0);
          pc         : out unsigned(6 downto 0);
          instr      : out unsigned(15 downto 0);
          a, ula_out : out unsigned(15 downto 0);
          reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out unsigned(15 downto 0)
    );
end processador;
architecture a_processador of processador is
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
        port( entrada0, entrada1      : in unsigned(15 downto 0);
              opcode                  : in unsigned(3 downto 0);
              control                 : in unsigned(1 downto 0);
              saida                   : out unsigned(15 downto 0);
              Z, carry_sum, carry_sub : out std_logic
        );
    end component;

    component rom is
        port ( clk    : in std_logic;
               adress : in unsigned(6 downto 0);
               data   : out unsigned(15 downto 0)
        );
    end component;

    component program_counter is
        port ( clk, wr_en, rst : in std_logic;
               data_i          : in unsigned(6 downto 0);
               data_o          : out unsigned(6 downto 0)
        );

    end component;

    component state_machine is
        port ( clk, rst : in std_logic;
               state    : out unsigned(1 downto 0)
        );
    end component;

    component control_unit is
        port ( clk, rst, Z               : in std_logic;
               state                     : in unsigned(1 downto 0);
               instr                     : in unsigned(15 downto 0);
               clk_rom                   : out std_logic := '0';
               mux_ula, mux_ban, wr_en_a : out std_logic;
               mux_acc                   : out std_logic_vector(1 downto 0); 
               control_ula               : out unsigned(1 downto 0); 
               reg_ula, wrt_ban          : out unsigned(2 downto 0);
               adress                    : out unsigned(6 downto 0);
               const                     : out unsigned(15 downto 0)  
        );
    end component;

    signal Z, carry_sum, carry_sub                 : std_logic := '0';
    signal clk_rom, mux_ula, mux_ban, wr_en_a      : std_logic := '0';
    signal control_ula, state_s                    : unsigned(1 downto 0) := "00";
    signal mux_acc                                 : std_logic_vector(1 downto 0) := "00";
    signal reg_in, wrt_ban                         : unsigned(2 downto 0) := "000";
    signal ula_out_s, instr_s, a_s, const, reg_out : unsigned(15 downto 0) := (others => '0');
    signal ula_in, acc_in, ban_in                  : unsigned(15 downto 0) := (others => '0');
    signal adress_in, adress_out                   : unsigned(6 downto 0) := (others => '0');
   
begin
    uut_ban_reg: ban_reg port map( reg_in, wrt_ban, ban_in, clk, rst, reg_out,
                                   reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 );

    uut_ula: ula port map( a_s, ula_in, instr_s(15 downto 12), control_ula, ula_out_s, Z, carry_sum, carry_sub );

    uut_accumulator: reg16bits port map( clk, rst, wr_en_a, acc_in, a_s );
    
    uut_instruction: reg16bits port map( clk, rst, '1', instr_s, instr );  
    
    uut_state_machine: state_machine port map ( clk, rst, state_s );

    uut_control_unit: control_unit port map ( clk, rst, Z, state_s, instr_s, clk_rom,
                                              mux_ula, mux_ban, wr_en_a, mux_acc,
                                              control_ula, reg_in, wrt_ban, adress_in,
                                              const );

    uut_pc: program_counter port map ( clk_rom, '1', rst, adress_in, adress_out );

    uut_rom: rom port map ( clk_rom, adress_out, instr_s );

    ula_in <= reg_out when mux_ula = '1' else
              const;

    acc_in <= reg_out when mux_acc = "00" else
              const when mux_acc = "01" else 
              ula_out_s;
   
    ban_in <= const when mux_ban = '1' else
              a_s;
    
    state <= state_s;
    pc <= adress_out;
    a <= a_s;
    ula_out <= ula_out_s;

end a_processador;
