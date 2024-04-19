library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity ULA is
    port(
        entrada0, entrada1 : in unsigned(15 downto 0);
        controle           : in unsigned(1 downto 0);
        saida              : out unsigned(15 downto 0);
        negativo, carry    : out std_logic := '0'
    );
end entity ULA;

architecture a_ULA of ULA is
begin
    process(controle) is
    begin
        case controle is
            when "00" =>
                if to_integer(entrada0) + to_integer(entrada1) > 65535 then
                    carry <= '1';
                else
                    carry <= '0';
                end if;
                saida <= resize(entrada1 + entrada0, saida'length);
            when "01" =>
                carry <= '0';
                if to_integer(entrada1) > to_integer(entrada0) then
                    saida <= entrada1-entrada0;
                    negativo <= '1';
                else
                    saida <= entrada0-entrada1;
                    negativo <= '0';
                end if;
            when "10" =>
                if to_integer(entrada0) * to_integer(entrada1) > 65535 then
                    carry <= '1';
                else
                    carry <= '0';
                end if;
                    saida <= resize(entrada1 * entrada0, saida'length);
            when "11" => 
                if integer(real(to_integer(entrada0))**real(to_integer(entrada1))) > 65535 then
                    carry <= '1';
                else
                    carry <= '0';
                end if;
                saida <= resize(to_unsigned(integer(real(to_integer(entrada0))**real(to_integer(entrada1))), 16), saida'length);
            when others => 
                saida <= (others => 'X');
        end case;
        if controle /= "01" then
            negativo <= '0';
        end if;
    end process;

end architecture a_ULA;