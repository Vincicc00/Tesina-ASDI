library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
-- riceve il dato dalla Macchina M e lo scrive in memoria
-- il write 
entity MEM is
    Port (
          CLK : in std_logic;
          input : in std_logic_vector(7 downto 0);
          address: in std_logic_vector(2 downto 0);
          write : in std_logic
         );
end MEM;

architecture Behavioral of MEM is
    type MEM_8_8 is array (0 to 7) of std_logic_vector(7 downto 0);
    signal memory: MEM_8_8:= (
        "00000000",
        "00000000", 
        "00000000", 
        "00000000", 
        "00000000", 
        "00000000", 
        "00000000", 
        "00000000"  
    );
begin
    main: process(CLK)
        begin
            if(CLK'event and CLK='1') then 
                if(write = '1') then 
                    memory(to_integer(unsigned(address))) <= input;
                end if;
             end if;
        end process; 
        

end Behavioral;

