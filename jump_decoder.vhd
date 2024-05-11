library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jump_decoder is
    port (
        instr  : in  unsigned(9 downto 0);
        target : out unsigned(6 downto 0)
    );
end entity;
                                    
architecture a_jump_decoder of jump_decoder is
    signal  opcode : unsigned(2 downto 0);         
begin
    opcode <= instr(9 downto 7);

    target <= instr(6 downto 0) when opcode = "111" else (others => '0');
end a_jump_decoder;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_jump_decoder is
    port (
        clk    : in std_logic;
        instr  : in unsigned(9 downto 0)
    );
end entity;
                                    
architecture a_top_jump_decoder of top_jump_decoder is
    component ROM is
        port ( clk    : in std_logic;
               adress : in unsigned(6 downto 0);
               data   : out unsigned(11 downto 0)
             );
    end component;

    component jump_decoder is
        port ( instr : in unsigned(9 downto 0);
               target : out unsigned(6 downto 0)
            );
    end component;
    
    signal   adress      : unsigned(6 downto 0);
    signal   data        : unsigned(11 downto 0);
    signal   target      : unsigned(6 downto 0);    

begin
    uutrom: ROM port map( clk => clk, 
                        adress => adress,
                        data => data);

    uutun_crtl: jump_decoder port map(instr => instr,
                                target => target);

    adress <= target;
end a_top_jump_decoder;

