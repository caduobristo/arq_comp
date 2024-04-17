library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity ULA is
    port(
        entrada0, entrada1 : in unsigned(15 downto 0);
        controle : in unsigned(1 downto 0);
        saida : out unsigned(15 downto 0)
    );
end entity ULA;

architecture a_ULA of ULA is
begin
    process(controle) is
    begin
        case controle is
            when "00" =>
                saida <= entrada0+entrada1;
            when "01" =>
                saida <= entrada0-entrada1;
            when "10" =>
                saida <= resize(entrada0*entrada1, 16);
            when "11" => 
                saida <= to_unsigned(integer(real(to_integer(entrada0))**real(to_integer(entrada1))), 16);
            when others => 
                saida <= (others => 'X');
        end case;
    end process;

end architecture a_ULA;