library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity ula is
    port( entrada0, entrada1      : in unsigned(15 downto 0);
          opcode                  : in unsigned(3 downto 0);
          control                 : in unsigned(1 downto 0);
          saida                   : out unsigned(15 downto 0);
          Z, carry_sum, carry_sub : out std_logic
    );
end entity ula;

architecture a_ula of ula is
    signal Z_s, carry_sums, carry_subs : std_logic := '0';
    signal saida_s                     : unsigned(15 downto 0);
    signal e0_s17, e1_s17, s17         : unsigned(16 downto 0);
begin                                   
    saida_s <= resize(entrada0 + entrada1, saida'length) when control = "00" else
               entrada0-entrada1                         when control = "01" else
               entrada0 and entrada1                     when control = "10" else
               entrada0 xor entrada1                     when control = "11" else
               (others => '0');

    Z_s <= '1' when opcode = "1010" and
                    control = "01" and
                    saida_s = "0000000000000000" else
           '0' when opcode = "1010" and
                    control = "01" else
           Z_s; 

    e0_s17 <= '0' & entrada0;
    e1_s17 <= '0' & entrada1;
    s17 <= e0_s17 + e1_s17;

    carry_sum <= s17(16);

    carry_sub <= '1' when entrada0 < entrada1 and
                 control = "11" else
                 '0';

    Z <= Z_s;
    saida <= saida_s;
end architecture a_ula;