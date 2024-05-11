library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(
        wr_en_in, rst_in, clk_in, control_in : in std_logic;
        top_in : in unsigned(15 downto 0);
        db_ula : out unsigned(15 downto 0)
    );
end top_level;

architecture top_levelarq of top_level is
    component ban_reg is
        port ( read1, read2, wrt  : in unsigned(2 downto 0);
               data_in            : in unsigned(15 downto 0);
               wr_en, rst, clk    : in std_logic;
               reg_out1, reg_out2 : out unsigned(15 downto 0)
        );
    end component;

    component ULA
        port( 
            entrada0, entrada1 : in unsigned(15 downto 0);
            controle           : in unsigned(1 downto 0);
            saida              : out unsigned(15 downto 0);
            negativo, carry    : out std_logic := '0'
        );
    end component;

   signal data_in, reg_out1, reg_out2, entrada0, entrada1, saida : unsigned(15 downto 0);
   signal read1, read2, wrt  : unsigned(2 downto 0); 
   signal controle : unsigned(1 downto 0);
   signal zero : unsigned(15 downto 0) := "0000000000000000";
   
begin
    entrada1 <= reg_out2 when control_in = '1' else
                top_in   when control_in = '0' else         
                zero;

    m_ban_reg: ban_reg port map( 
        wr_en => wr_en_in, 
        rst => rst_in, 
        clk => clk_in, 
        read2 => read2,
        read1 => read1, 
        reg_out1 => reg_out1, 
        reg_out2 => reg_out2,
        data_in => saida, 
        wrt => wrt
    );

    m_ula: ULA port map(
        entrada0 => reg_out1, 
        entrada1 => entrada1, 
        saida => saida, 
        controle => controle
    ); 

    db_ula <= saida;

end top_levelarq;
