library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_B is
    
    Port (
          clock: in std_logic;
          reset: in std_logic;
          strobe: in std_logic;
          enable_count: out std_logic;  -- abilitiamo il conteggio
          ACK: out std_logic;
          write: out std_logic;
          read: out std_logic;
          load_reg: out std_logic  -- abilitiamo il registro a salvare il dato
           );
end CU_B;

architecture Behavioral of CU_B is
    type state is (idle, leggo, somma, fine_somma);
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
    
    comb: process(current_state, strobe)
    begin 
      CASE current_state is
        WHEN idle =>
            ACK <= '1';
            enable_count <= '0';
            if(strobe = '1') then 
                next_state <= leggo;
            else 
                next_state <= idle;
            end if;
        WHEN leggo => 
            ACK <= '0';
            load_reg <='1';  -- salviamo X(i) in reg 
            read <= '1';
            enable_count <= '0';
            -- INVIAMO X(i) e Y(i) all'adder  e sommiamo
            next_state <= somma;
        WHEN somma =>
            
            load_reg <= '0';
            write <= '1'; -- qua diciamo di scrivere il risultato della somma in MEM
            next_state <= fine_somma;
        WHEN fine_somma =>
            enable_count <= '1';
            write <= '0';
            next_state <= idle;
        
      end CASE;      
    end process; 
end Behavioral;
