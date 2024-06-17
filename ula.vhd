library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity ula is
    port( entrada0, entrada1 : in unsigned(15 downto 0);
          control            : in unsigned(1 downto 0);
          saida              : out unsigned(15 downto 0);
          z, carry           : out std_logic
    );
end entity ula;

architecture a_ula of ula is
    signal saida_s                       : unsigned(15 downto 0) := (others => 'X');
    signal e0_s17, e1_s17, s17           : unsigned(16 downto 0);
begin                                   
    saida_s <= resize(entrada0 + entrada1, saida'length) when control = "00" else
               entrada0-entrada1                         when control = "01" else
               entrada0 and entrada1                     when control = "10" else
               entrada0 xor entrada1                     when control = "11" else
               saida_s;

    z <= '1' when saida_s = "0000000000000000" else
         '0'; 

    e0_s17 <= '0' & entrada0;
    e1_s17 <= '0' & entrada1;
    s17 <= e0_s17 + e1_s17;

    carry <= '1' when s17(16) = '1' or
                      entrada0 < entrada1 else
             '0';

    saida <= saida_s;
end architecture a_ula;