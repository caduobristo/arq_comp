library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port ( clk, rst, z, carry : in std_logic;
           state              : in unsigned(1 downto 0);
           instr, reg         : in unsigned(15 downto 0);
           clk_rom, exception : out std_logic;
           adress             : out unsigned(6 downto 0)
    );
end entity;

architecture a_adder of adder is
    
    signal adress_s : unsigned(7 downto 0) := (others => '0');
    signal adress_signed : signed(7 downto 0) := (others => '0');
    signal exception_s : std_logic;
begin


process(clk, instr)
begin
    clk_rom <= '0';
    if rising_edge(clk) then
        if rst = '1' then 
            adress_s <= "00000000";
        elsif exception_s = '1' and state = "00" then
            adress_s <= "00000000";
        else
            if instr(15 downto 12) = "1011" then
                adress_s <= '0' & instr(11 downto 5);
                clk_rom <= '1'; 
            elsif ((instr(15 downto 12) = "1101") and z = '0') or
                ((instr(15 downto 12) = "1110") and carry = '1') then
                adress_signed <= resize((signed("1" & instr(11 downto 5)) + signed(resize(adress_s,8))), 8) - 1;
                adress_s <= unsigned(adress_signed);
                clk_rom <= '1'; 
            elsif ((instr(15 downto 12) = "1100") and reg(to_integer(instr(8 downto 5))) = '0') then
                adress_signed <= resize((signed("111" & instr(4 downto 0)) + signed(resize(adress_s,8))), 8) - 1;
                adress_s <= unsigned(adress_signed);
                clk_rom <= '1';
            elsif state = "00" then 
                exception_s <= adress_s(7);
                adress_s <= adress_s + 1;
            end if;
        end if;
    end if;
end process;

exception <= exception_s;
adress <= resize(adress_s, 7);
end a_adder;