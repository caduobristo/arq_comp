library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ban_reg is
    port ( read1, read2, wrt  : in unsigned(2 downto 0);
           data_in            : in unsigned(15 downto 0);
           clk, rst           : in std_logic;
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

    signal reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg_instr : unsigned(15 downto 0);
    signal zero : unsigned(15 downto 0) := "0000000000000000";
    signal mux : unsigned(6 downto 0);

begin   
    mux <= "0000001" when wrt = "001" else
           "0000010" when wrt = "010" else
           "0000100" when wrt = "011" else
           "0001000" when wrt = "100" else
           "0010000" when wrt = "101" else
           "0100000" when wrt = "110" else
           "1000000" when wrt = "111" else
           "0000000";

    register1: reg16bits port map(clk => clk, rst => rst, wr_en => mux(0), data_in => data_in, data_out => reg1);
    register2: reg16bits port map(clk => clk, rst => rst, wr_en => mux(1), data_in => data_in, data_out => reg2);
    register3: reg16bits port map(clk => clk, rst => rst, wr_en => mux(2), data_in => data_in, data_out => reg3);
    register4: reg16bits port map(clk => clk, rst => rst, wr_en => mux(3), data_in => data_in, data_out => reg4);
    register5: reg16bits port map(clk => clk, rst => rst, wr_en => mux(4), data_in => data_in, data_out => reg5);
    register6: reg16bits port map(clk => clk, rst => rst, wr_en => mux(5), data_in => data_in, data_out => reg6);
    register7: reg16bits port map(clk => clk, rst => rst, wr_en => mux(6), data_in => data_in, data_out => reg7);

    reg_out1 <= reg1 when read1 = "001" else
                reg2 when read1 = "010" else
                reg3 when read1 = "011" else
                reg4 when read1 = "100" else
                reg5 when read1 = "101" else
                reg6 when read1 = "110" else
                reg7 when read1 = "111" else
                zero;
        
    reg_out2 <= reg1 when read2 = "001" else
                reg2 when read2 = "010" else
                reg3 when read2 = "011" else
                reg4 when read2 = "100" else
                reg5 when read2 = "101" else
                reg6 when read2 = "110" else
                reg7 when read2 = "111" else
                zero; 
        
end a_ban_reg;