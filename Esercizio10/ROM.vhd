library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    port(
        CLK : in std_logic;
        address : in  std_logic_vector(2 downto 0);
        dout    : out std_logic_vector(7 downto 0);
        read : in std_logic
    );
end entity ROM;

architecture Behavioral of ROM is
    type MEMORY_8_8 is array (0 to 7) of std_logic_vector(7 downto 0);      
    constant ROM_8_8 : MEMORY_8_8 :=( 	             
        "00001000",--8
        "00001001",--9
        "00001010",--10
        "00001011",--11
        "00001100",--12
        "00001101",--13
        "00001110",--14
        "00101111"--47
    );
begin
    
    main : process(CLK)
    begin
        if(ClK'event and CLK = '1') then 
            if (read ='1') then 
               dout <= ROM_8_8(to_integer(unsigned(address)));
            end if;
        end if;
    end process;


end Behavioral;
