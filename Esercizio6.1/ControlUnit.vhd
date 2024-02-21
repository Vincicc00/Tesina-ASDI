
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ControlUnit is
    Port (
          CLK: in std_logic;
          RST: in std_logic; 
          start: in std_logic;
          en_input: inout std_logic;
          en_read: inout std_logic;
          en_write: inout std_logic
          );
end ControlUnit;

architecture Behavioral of ControlUnit is
    
    type state is (
               idle,
               counting,
               start_reading,
               start_writing
              );
     
     signal current_state: state := idle; 
     signal next_state: state;
         
begin
   exit_state: process(CLK) 
   begin 
       if(CLK'event and CLK ='1') then 
        if(RST = '1') then 
          en_input <= '0';
          en_write <= '0';
          en_read <= '0';
          current_state <= idle;
        else
        if(start = '0') then 
            case current_state is 
                when idle => 
                    en_input <= '0';
                    en_write <= '0';
                    en_read <= '0';
                    current_state <= idle;
                when others => 
                    current_state <= idle;
            end case;
        end if;
        if(start = '1') then 
            case current_state is 
                when idle =>
                    en_input <= '0';
                    en_write <= '0';
                    en_read <= '0';
                    current_state <= counting;
                when counting => 
                    en_input <= '1';
                    en_write <= '0';
                    en_read <= '0';
                    current_state <= start_reading;
                when start_reading =>
                    en_input <= '0';
                    en_write <= '0';
                    en_read <= '1';
                    current_state <= start_writing;
                when start_writing =>
                    en_input <= '0';
                    en_write <= '1';
                    en_read <= '0';
                    current_state <= counting;
            end case;     
        end if;
      end if;            
     end if;
    end process;     
    
end Behavioral;
