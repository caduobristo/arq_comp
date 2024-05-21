library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity ula is
    port( entrada0, entrada1 : in unsigned(15 downto 0);
          control            : in unsigned(1 downto 0);
          saida              : out unsigned(15 downto 0)
    );
end entity ula;

architecture a_ula of ula is
begin                                   
    saida <= resize(entrada0 + entrada1, saida'length) when control = "00" else
             entrada0-entrada1                         when control = "01" else
             entrada0 and entrada1                     when control = "10" else
             entrada0 xor entrada1                     when control = "11" else
             (others => '0');

end architecture a_ula;