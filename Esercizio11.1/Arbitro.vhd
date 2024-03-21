
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arbitro is
    Port (
          ing0: in std_logic_vector(1 downto 0);  -- primo ingresso switch alto sx
          ing1: in std_logic_vector(1 downto 0);  -- primo ingresso switch basso sx
          ing2: in std_logic_vector(1 downto 0);  -- secondo ingresso switch alto sx
          ing3: in std_logic_vector(1 downto 0);  -- secondo ingresso switch basso sx
          as: out std_logic_vector(1 downto 0);   --indirizzo di selezione sorgente
          usc0: out std_logic_vector(1 downto 0); -- prima uscta alto dx
          usc1: out std_logic_vector(1 downto 0); -- seconda uscta alto dx
          usc2: out std_logic_vector(1 downto 0); -- prima uscta basso dx
          usc3: out std_logic_vector(1 downto 0)  -- seconda uscta basso dx 
         );
end Arbitro;

architecture Behavioral of Arbitro is
    
    

begin
    
    process(ing0,ing1,ing2,ing3)
        begin 
            if(ing0 /= "00") then   --se l'ingresso0 è diverso da 00 tutti gli altri sono 00 
                as <= "00";
                usc0 <= ing0;
                usc1 <= "00";
                usc2 <= "00";
                usc3 <= "00";
            elsif(ing1 /= "00") then 
                as <= "01";
                usc0 <= "00";
                usc1 <= ing1;
                usc2 <= "00";
                usc3 <= "00";
            elsif(ing2 /= "00") then 
                as <= "10";
                usc0 <= "00";
                usc1 <= "00";
                usc2 <= ing2;
                usc3 <= "00";
            else
                as <= "11";
                usc0 <= "00";
                usc1 <= "00";
                usc2 <= "00";
                usc3 <= ing3;
           end if;
            
   end process; 
    

end Behavioral;
