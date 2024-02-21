library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System_S is
   Port (
         switches: in std_logic_vector(3 downto 0);
         leds: out std_logic_vector(3 downto 0)
        );
end System_S;

architecture Structural of System_S is
    component rom
        port(
             address : in  std_logic_vector(3 downto 0);
             dout    : out std_logic_vector(7 downto 0)
            );
    end component;
    
    component M
        port(
             input   : in  std_logic_vector(7 downto 0);
             output  : out std_logic_vector(3 downto 0)
            );
     end component;
            
      signal temp: std_logic_vector(7 downto 0):=(others=>'0');
begin
    
     mem: rom 
        port map(
                  switches,
                  temp
                 );
     
     Macchina_m: M
        port map(
                 temp,
                 leds
                );

end Structural;
