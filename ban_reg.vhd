library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ban_reg is
    port ( read_in, wrt : in unsigned(2 downto 0);
           data_in      : in unsigned(15 downto 0);
           clk, rst     : in std_logic;
           read_out, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out unsigned(15 downto 0)
    );
end ban_reg;

architecture a_ban_reg of ban_reg is
    component reg16bits is
       port ( clk, rst, wr_en : in std_logic;
              data_in         : in unsigned(15 downto 0);
              data_out        : out unsigned(15 downto 0)
       );
    end component;  

    signal zero : unsigned(15 downto 0) := "0000000000000000";
    signal mux  : unsigned(6 downto 0) := (others => '0');
    signal reg1_s, reg2_s, reg3_s, reg4_s, reg5_s, reg6_s, reg7_s : unsigned(15 downto 0) := (others => '0');

begin   
    mux <= "0000001" when wrt = "001" else
           "0000010" when wrt = "010" else
           "0000100" when wrt = "011" else
           "0001000" when wrt = "100" else
           "0010000" when wrt = "101" else
           "0100000" when wrt = "110" else
           "1000000" when wrt = "111" else
           "0000000";

    register1: reg16bits port map(clk => clk, rst => rst, wr_en => mux(0), data_in => data_in, data_out => reg1_s);
    register2: reg16bits port map(clk => clk, rst => rst, wr_en => mux(1), data_in => data_in, data_out => reg2_s);
    register3: reg16bits port map(clk => clk, rst => rst, wr_en => mux(2), data_in => data_in, data_out => reg3_s);
    register4: reg16bits port map(clk => clk, rst => rst, wr_en => mux(3), data_in => data_in, data_out => reg4_s);
    register5: reg16bits port map(clk => clk, rst => rst, wr_en => mux(4), data_in => data_in, data_out => reg5_s);
    register6: reg16bits port map(clk => clk, rst => rst, wr_en => mux(5), data_in => data_in, data_out => reg6_s);
    register7: reg16bits port map(clk => clk, rst => rst, wr_en => mux(6), data_in => data_in, data_out => reg7_s);

    read_out <= reg1_s when read_in = "001" else
                reg2_s when read_in = "010" else
                reg3_s when read_in = "011" else
                reg4_s when read_in = "100" else
                reg5_s when read_in = "101" else
                reg6_s when read_in = "110" else
                reg7_s when read_in = "111" else
                zero;
        
    reg0 <= zero;
    reg1 <= reg1_s;
    reg2 <= reg2_s;
    reg3 <= reg3_s;
    reg4 <= reg4_s;
    reg5 <= reg5_s;
    reg6 <= reg6_s;
    reg7 <= reg7_s;
        
end a_ban_reg;