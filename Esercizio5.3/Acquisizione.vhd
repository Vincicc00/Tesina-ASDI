
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Acquisizione is
    Port (
          CLK: in std_logic;
          RST: in std_logic;
          load: in std_logic;
          dato_s: out std_logic_vector(5 downto 0);  
          dato_m: out std_logic_vector(5 downto 0);  
          dato_h: out std_logic_vector(4 downto 0);
          data: in std_logic_vector(5 downto 0)
         );
end Acquisizione;

architecture Behavioral of Acquisizione is
    signal x: integer range 0 to 3 ; 
begin
   
main: process(CLK)
begin   
  if(CLK'event and CLK='1') then   
    if(load = '1' and x = 0) then 
        dato_s <= data;
        x <= x+1;
    end if;
    if(load = '1' and x = 1) then 
        dato_m <= data;
        x <= x+1;
    end if;
    if(load = '1' and x = 2) then 
        dato_h <= data(4 downto 0);
        x <= 0;
    end if;
  end if;
end process;

end Behavioral;
