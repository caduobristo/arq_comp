library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula_tb is
end entity ula_tb;

architecture a_ula_tb of ula_tb is
    component ula
        port( entrada0, entrada1 : in unsigned(15 downto 0);
              control            : in unsigned(1 downto 0);
              saida              : out unsigned(15 downto 0)
        );
    end component;

    signal entrada0, entrada1 : unsigned(15 downto 0);
    signal controle           : unsigned(1 downto 0);
    signal saida              : unsigned(15 downto 0);

begin
    uut : ula port map( entrada0 => entrada0,
                        entrada1 => entrada1,
                        control  => controle,
                        saida    => saida );

    processo_teste: process
    begin
        -- casos base
        entrada0 <= to_unsigned(3, 16);
        entrada1 <= to_unsigned(3, 16);
        controle <= "00";
        wait for 5 ns;
        
        entrada0 <= to_unsigned(6, 16);
        entrada1 <= to_unsigned(3, 16);
        controle <= "01";
        wait for 5 ns;
        
        entrada0 <= to_unsigned(2, 16);
        entrada1 <= to_unsigned(3, 16);
        controle <= "10";
        wait for 5 ns;
        
        entrada0 <= to_unsigned(3, 16);
        entrada1 <= to_unsigned(2, 16);
        controle <= "11";
        wait for 5 ns;
        wait;
        
    end process processo_teste;

end architecture a_ula_tb;
