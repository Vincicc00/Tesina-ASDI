library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Riceve la locazione di memoria dalla ROM e poi 
-- la invia elaborata alla MEM
entity Macchina_M is
    port(
        input   : in  std_logic_vector(7 downto 0);
        output  : out std_logic_vector(3 downto 0)
    );
end entity Macchina_M;

architecture r of Macchina_M is

begin  
    
    main : process(input)
    begin

    
    output <= input(7) & input(5) & input(3) & input(1);    

    end process main;

end architecture r;