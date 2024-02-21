
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_101 is
  port( 
      i: in std_logic;   --- switch V10
      enable_input: in std_logic;  --bottone P17
      A,RST: in std_logic; -- A = clock  RST = Bottone C12
      M : in std_logic;  --  switch U11
      enable_M: in std_logic;  -- bottone M17
      Y: out std_logic  -- led H17
      --debug: out std_logic
  );
end Riconoscitore_101;

architecture Behavioral_2proc of Riconoscitore_101 is

type stato is (S0, S1, S2, S3, S4);

signal stato_corrente : stato := S0;
signal stato_prossimo : stato;
signal temp: std_logic:= M;
begin

stato_uscita: process(stato_corrente, i ,M)
  begin
  if ( M = '1') then    -- funzionamento sovrapposizione parziale 
     case stato_corrente is
      when S0 =>
        if( i = '0' ) then
          stato_prossimo <= S0;
          Y <= '0';
        else 
          stato_prossimo <= S1;
          Y <= '0';
        end if;
      when S1 =>
        if( i = '0' ) then
          stato_prossimo <= S2;
          Y <= '0';
        else
          stato_prossimo <= S1;
          Y <= '0';
        end if;
      when S2 =>
        if( i = '0' ) then
          stato_prossimo <= S0;
          Y <= '0';
        else
          stato_prossimo <= S0;
          Y <= '1';
        end if;
      when others =>  -- gestiamo tutti gli altri stati definiti e non utilizzati (S3,S4)
           Y <= '0';
    end case;
    end if;
    if ( M = '0') then -- funzionamento riconoscitore senza sovrapposizioni
        case stato_corrente is
            when S0 => 
                if(i = '0') then 
                    stato_prossimo <= S1;
                    Y <= '0';
                 else 
                    stato_prossimo <= S2;
                    Y <= '0';
                 end if; 
             when S1 =>
                if (i = '0') then 
                    stato_prossimo <= S4;
                    Y <= '0'; 
                else
                    stato_prossimo <= S4;
                    Y <= '0';
                end if;
              when S2 =>
                if(i = '0') then 
                    stato_prossimo <= S3;
                    Y <= '0';
                else 
                    stato_prossimo <= S4; 
                    Y <= '0';
                end if;
               when S3 =>
                    if( i = '0') then 
                        stato_prossimo <= S0;
                        Y <= '0';
                     else                   
                        stato_prossimo <= S0;
                        Y <= '1';
                     end if;
                when S4 =>
                    if( i = '0') then 
                        stato_prossimo <= S0; 
                        Y <= '0';
                    else
                    stato_prossimo <= S0; 
                        Y <= '0';
                    end if; 
              end case;
           end if; 
end process;
-- questo processo rappresenta la parte combinatoria di una macchina sequenziale
-- attenzione: l'uscita viene aggiornata da un processo puramente combinatorio
-- quindi appena mi trovo in S2 se i diventa 1 l'uscita si alza immediatamente


-- questo processo rappresenta gli elementi di memoria 
mem: process(A)
begin  
  --temp <= M;
  if( A'event and A = '1' ) then
    if( RST = '1') then   
         stato_corrente <= S0;
    else
        if(enable_M = '1') then
            if(M /= temp) then    
            -- temp è una varibile d'appoggio che usiamo per salvare M all'inizio 
            stato_corrente <= S0;  
            -- ripristiniamo il riconoscitore perchè abbiamo cambiato modo
             temp <= M; 
            end if;  
        end if;   
        if( enable_input = '1') then
            stato_corrente <= stato_prossimo;
        end if;
    end if;
  end if;
end process;


end Behavioral_2proc;

