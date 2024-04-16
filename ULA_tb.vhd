library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port( entrada0, entrada1 : in unsigned(15 downto 0);
              controle : in unsigned(1 downto 0);
              saida : out unsigned(15 downto 0)
        );
    end component;
    signal entrada0, entrada1, saida : unsigned(15 downto 0);
    signal controle : unsigned(1 downto 0);
begin
    uut: ULA port map( entrada0 => entrada0,
                       entrada1 => entrada1,
                       saida => saida,
                       controle => controle);
    entrada0 <= "0000000000000100";
    entrada1 <= "0000000000000010";
    process
    begin
        controle <= "00";
        wait for 50 ns;
        controle <= "01";
        wait for 50 ns;
        controle <= "10";
        wait for 50 ns;
        controle <= "11";
        wait for 50 ns;
        wait;
    end process;

end architecture a_ULA_tb;