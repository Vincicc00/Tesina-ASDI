library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity counter is
  generic(
        m : integer := 8;  -- questo ci dice fino a che conta il counter
        n : integer := 3   -- questo ci da la lunghezza del vector, il numero di bit
    );
  Port (
        CLK : in std_logic;
        RESET: in std_logic;
        enable: in std_logic;
        load: in std_logic;
        data: in std_logic_vector(n-1 downto 0);
        y: out std_logic_vector(n-1 downto 0); -- uscita contatore
        count: out std_logic   -- ci serve per abilitare il contatore successivo
       );
end counter;

architecture Behavioral of counter is
    signal temp : std_logic_vector(n-1 downto 0):=(others=>'0');
    signal scount : std_logic;
begin
    
    y <= temp;
    
    conteggio: process(CLK)
        begin 
            if(CLK'event and CLK ='0') then 
                if(RESET = '1') then 
                    temp <= (others => '0');
                elsif(load = '1') then 
                    temp <= data;
                elsif(enable = '1') then 
                   if(temp = std_logic_vector(to_unsigned(m-1,n))) then  
                   -- se arriva al massimo conteggio azzeriamo il contatore
                        temp <= (others => '0');
                   else     
                        temp <= std_logic_vector(unsigned(temp) + 1);  -- vai avanti nel conteggio
                   end if;
                end if;
            end if;
        end process;
        
     abilitazione: process(CLK)
        begin 
            if(CLK'event and CLK='1') then 
                if(RESET = '1') then 
                    scount <= '0';
                elsif(temp = std_logic_vector(to_unsigned(m-1,n))) then
                    -- se arriviamo al massimo conteggio abilitiamo il contatore successivo 
                    scount <= '1'; 
                else 
                    scount <= '0';
                end if; 
            end if; 
        end process; 
        
     count <= scount; 
end Behavioral;
