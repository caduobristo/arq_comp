library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port ( clk, rst : in std_logic;
           state    : in unsigned(1 downto 0);
           instr    : in unsigned(15 downto 0);
           clk_rom  : out std_logic;
           adress   : out unsigned(6 downto 0)
    );
end entity;

architecture a_adder of adder is
    signal adress_s : unsigned(6 downto 0) := (others => '0');
begin

process(clk, instr)
begin
    clk_rom <= '0';
    if rising_edge(clk) then
        if rst = '1' then 
            adress_s <= "0000000";
        elsif instr(15 downto 12) = "1011" then
            adress_s <= instr(11 downto 5);
            clk_rom <= '1'; 
        elsif state = "00" then 
            adress_s <= adress_s + 1;
        end if;
    end if;
end process;

adress <= adress_s;
end a_adder;