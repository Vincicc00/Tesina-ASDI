library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
-- questo prende lo start, conta e manda l'address alla ROM (forse anche MEM)
entity counter is
  generic(
        n : integer := 3   -- questo ci da la lunghezza del vector, il numero di bit
    );
  Port (
        CLK : in std_logic;
        RST: in std_logic;
        enable: in std_logic;  --- lo colleghiamo al segnale di start
        y: out std_logic_vector(n-1 downto 0) -- uscita contatore
       );
end counter;

architecture Behavioral of counter is
    signal temp : std_logic_vector(n-1 downto 0):=(others=>'0');
begin
    
    y <= temp;
    
    conteggio: process(CLK)
        begin 
            if(CLK'event and CLK ='1') then 
                if(RST = '1') then 
                    temp <= (others => '0');
                elsif(enable = '1') then      
                        temp <= std_logic_vector(unsigned(temp) + 1);  -- vai avanti nel conteggio
                end if;
            end if;
        end process;
        

end Behavioral;
