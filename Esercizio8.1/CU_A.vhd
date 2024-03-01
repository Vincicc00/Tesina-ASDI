
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_A is
    Port (
          clock: in std_logic;
          reset: in std_logic;
          strobe: out std_logic;
          ACK: in std_logic;
          read: out std_logic;
          enable_count: out std_logic
         );
end CU_A;

architecture Behavioral of CU_A is
    
    type state is (idle, invio_dato, leggi);
    signal current_state,next_state:state;
    
begin
    reg_stato: process(clock)
        begin
        if(clock'event and clock='1') then
             if(reset='1') then 
            current_state <=idle;
          else 
            current_state <=next_state;
           end if;
        end if;
        end process;
        
    comb: process(current_state, ACK)
    begin 
      CASE current_state is
        WHEN idle => 
            strobe <= '0';
            enable_count <= '0';
            if(ACK = '1') then 
                next_state <= invio_dato;
            else
                next_state <= idle;
            end if;
            
        WHEN invio_dato =>
            strobe <= '1';
            read <= '1';
            next_state <= leggi;
        WHEN leggi =>
            enable_count <= '1';
            read <= '0';
            next_state <= idle;
       end CASE;
    
    end process;
    
end Behavioral;
