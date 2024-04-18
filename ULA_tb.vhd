library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA_tb is
end entity ULA_tb;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port( 
            entrada0, entrada1 : in unsigned(15 downto 0);
            controle           : in unsigned(1 downto 0);
            saida              : out unsigned(15 downto 0);
            negativo, carry    : out std_logic := '0'
        );
    end component;

    signal entrada0_tb, entrada1_tb : unsigned(15 downto 0);
    signal controle_tb              : unsigned(1 downto 0);
    signal saida_tb                 : unsigned(15 downto 0);
    signal negativo_tb, carry_tb    : std_logic;

begin

    uut : ULA port map( entrada0 => entrada0_tb,
                        entrada1 => entrada1_tb,
                        controle => controle_tb,
                        negativo => negativo_tb,
                        carry    => carry_tb,
                        saida    => saida_tb
                    );

    processo_teste: process
    begin
        -- casos base
        entrada0_tb <= to_unsigned(3, 16);
        entrada1_tb <= to_unsigned(1, 16);
        controle_tb <= "00";
        wait for 2 ns;
        
        entrada0_tb <= to_unsigned(4, 16);
        entrada1_tb <= to_unsigned(2, 16);
        controle_tb <= "01";
        wait for 2 ns;
        
        entrada0_tb <= to_unsigned(2, 16);
        entrada1_tb <= to_unsigned(2, 16);
        controle_tb <= "10";
        wait for 2 ns;
        
        entrada0_tb <= to_unsigned(2, 16);
        entrada1_tb <= to_unsigned(3, 16);
        controle_tb <= "11";
        wait for 2 ns;
        
        --casos de interesse
        entrada0_tb <= to_unsigned(2, 16);
        entrada1_tb <= to_unsigned(4, 16);
        controle_tb <= "01";
        wait for 2 ns;

        entrada0_tb <= "1111111111111111";
        entrada1_tb <= "1111111111111111";
        controle_tb <= "11";
        wait for 2 ns;

        entrada0_tb <= "1111111111111111";
        entrada1_tb <= "1111111111111111";
        controle_tb <= "10";
        wait for 2 ns;
        wait;
        
    end process processo_teste;

end architecture a_ULA_tb;
