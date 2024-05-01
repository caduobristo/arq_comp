library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ban_reg is
    port ( read1, read2, wrt  : in unsigned(2 downto 0);
           data_in            : in unsigned(15 downto 0);
           wr_en, rst, clk    : in std_logic;
           reg_out1, reg_out2 : out unsigned(15 downto 0)
    );
end ban_reg;

architecture a_ban_reg of ban_reg is
    component reg16bits is
      port ( clk, rst, wr_en : in std_logic;
             data_in         : in unsigned(15 downto 0);
             data_out        : out unsigned(15 downto 0)
           );
    end component;  

    signal reg1, reg2, reg3, reg4, reg5, reg6, reg7, data_out : unsigned(15 downto 0); 
    signal reg0 : unsigned(15 downto 0) := "0000000000000000";

begin
    uut: reg16bits port map( clk => clk, rst => rst, wr_en => wr_en,
                             data_in => data_in, data_out => data_out);
    
    process(clk) is
    begin
        case wrt is
            when "001" =>
                reg1 <= data_out;
            when "010" =>
                reg2 <= data_out;
            when "011" =>
                reg3 <= data_out;
            when "100" =>
                reg4 <= data_out;
            when "101" =>
                reg5 <= data_out;
            when "110" =>
                reg6 <= data_out;
            when "111" =>
                reg7 <= data_out;
            when others =>
        end case;
    end process;

    reg_out1 <= reg1 when read1 = "001" else
                reg2 when read1 = "010" else
                reg3 when read1 = "011" else
                reg4 when read1 = "100" else
                reg5 when read1 = "101" else
                reg6 when read1 = "110" else
                reg7 when read1 = "111" else
                reg0;
        
    reg_out2 <= reg1 when read2 = "001" else
                reg2 when read2 = "010" else
                reg3 when read2 = "011" else
                reg4 when read2 = "100" else
                reg5 when read2 = "101" else
                reg6 when read2 = "110" else
                reg7 when read2 = "111" else
                reg0; 
        
end a_ban_reg;