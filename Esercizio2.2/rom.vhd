library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    port(
        address : in  std_logic_vector(3 downto 0);
        dout    : out std_logic_vector(7 downto 0)
    );
end entity ROM;

architecture RTL of ROM is
    type MEMORY_16_8 is array (0 to 15) of std_logic_vector(7 downto 0);     
    constant ROM_16_8 : MEMORY_16_8 :=(        
        "00000000",--0        
        "00000001",--0
        "00000010",--1 
        "00000011",--1 
        "00000100",--0
        "00000101",
        "00000110",
        "00000111",
        "00001000",
        "00001001",
        "00101010",
        "00001011",
        "00001100",
        "00001101",
        "00001110",
        "00101111"
    );
begin
    main : process(address)
    begin
        dout <= ROM_16_8(to_integer(unsigned(address)));
    end process main;

end architecture RTL;