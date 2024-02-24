library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Encoder is
    Port(
         secondi : in STD_LOGIC_VECTOR(5 downto 0);
         minuti: in STD_LOGIC_VECTOR(5 downto 0);
         ore: in STD_LOGIC_VECTOR(4 downto 0);
         Y : out STD_LOGIC_VECTOR(31 downto 0)
       );
end Encoder;

architecture Dataflow of Encoder is
     signal temps: STD_LOGIC_VECTOR(7 downto 0);
     signal tempm: STD_LOGIC_VECTOR(7 downto 0);
     signal tempo: STD_LOGIC_VECTOR(7 downto 0);
begin
    Y <= "00000000" & tempo & tempm & temps;
    --gestiamo la prima cifra dei secondi
    with to_integer(unsigned(secondi)) select
        temps(3 downto 0) <= "0000" when 0|10|20|30|40|50,
                             "0001" when 1|11|21|31|41|51,
                             "0010" when 2|12|22|32|42|52,
                             "0011" when 3|13|23|33|43|53,
                             "0100" when 4|14|24|34|44|54,
                             "0101" when 5|15|25|35|45|55,
                             "0110" when 6|16|26|36|46|56,
                             "0111" when 7|17|27|37|47|57,
                             "1000" when 8|18|28|38|48|58,
                             "1001" when 9|19|29|39|49|59,
                             "1111" when others;
                             
        --gestiamo la seconda cifra dei secondi 
        with to_integer(unsigned(secondi)) select
        temps(7 downto 4) <= "0000" when 0 to 9,
                             "0001" when 10 to 19,
                             "0010" when 20 to 29,
                             "0011" when 30 to 39,
                             "0100" when 40 to 49,
                             "0101" when 50 to 59,
                             "1111" when others;
                             
        --gestiamo la prima cifra dei minuti
        with to_integer(unsigned(minuti)) select
        tempm(3 downto 0) <= "0000" when 0|10|20|30|40|50,
                             "0001" when 1|11|21|31|41|51,
                             "0010" when 2|12|22|32|42|52,
                             "0011" when 3|13|23|33|43|53,
                             "0100" when 4|14|24|34|44|54,
                             "0101" when 5|15|25|35|45|55,
                             "0110" when 6|16|26|36|46|56,
                             "0111" when 7|17|27|37|47|57,
                             "1000" when 8|18|28|38|48|58,
                             "1001" when 9|19|29|39|49|59,
                             "1111" when others;
          
        --gestiamo la seconda cifra dei minuti 
        with to_integer(unsigned(minuti)) select
        tempm(7 downto 4) <= "0000" when 0 to 9,
                             "0001" when 10 to 19,
                             "0010" when 20 to 29,
                             "0011" when 30 to 39,
                             "0100" when 40 to 49,
                             "0101" when 50 to 59,
                             "1111" when others;
                             
       --gestiamo la prima cifra delle ore
        with to_integer(unsigned(ore)) select
        tempo(3 downto 0) <= "0000" when 0|10|20,
                             "0001" when 1|11|21,
                             "0010" when 2|12|22,
                             "0011" when 3|13|23,
                             "0100" when 4|14,
                             "0101" when 5|15,
                             "0110" when 6|16,
                             "0111" when 7|17,
                             "1000" when 8|18,
                             "1001" when 9|19,
                             "1111" when others;
                             
         --gestiamo la seconda cifra delle ore 
        with to_integer(unsigned(ore)) select
        tempo(7 downto 4) <= "0000" when 0 to 9,
                             "0001" when 10 to 19,
                             "0010" when 20 to 23,
                             "1111" when others;
end Dataflow;
