
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System_Board is
    Port (
          C: in std_logic;
          RST: in std_logic;
          start: in std_logic;
          read: in std_logic;
          leds: out std_logic_vector(3 downto 0) 
         );
end System_Board;

architecture Structural of System_Board is
   
    component ButtonDebouncer
        generic (                       
                 CLK_period: integer := 10; 
                 btn_noise_time: integer := 10000000 
                );
        Port (
              RST : in STD_LOGIC;
              CLK : in STD_LOGIC;
              BTN : in STD_LOGIC;
              CLEARED_BTN : out STD_LOGIC
             );
     end component;
        
    component System
        Port (
          CLOCK: in std_logic;
          RESET: in std_logic;
          start: in std_logic;   -- questo va in ingresso alla CU 
          en_r: inout std_logic;
          en_w: inout std_logic;
          en_i: inout std_logic;
          y0 : out std_logic_vector(3 downto 0); -- debugging per vedere se la locazione trasformata dalla macchina M viene scritta
          bot_read: in std_logic
         );
     end component; 
     
     signal bot_s: std_logic;
     signal bot_r: std_logic;
     signal tempr: std_logic:='0';
     signal tempw: std_logic:='0';
     signal tempi: std_logic:='0';
     signal temps: std_logic:='0';
begin
     
     bs: ButtonDebouncer
        generic map(
                    10,
                    10000000
                   )
         port map(
                  RST => RST,
                  CLK => C,
                  BTN => start,
                  CLEARED_BTN => bot_s
                 );
      
      br: ButtonDebouncer
        generic map(
                    10,
                    10000000
                   )
         port map(
                  RST => RST,
                  CLK => C,
                  BTN => read,
                  CLEARED_BTN => bot_r
                 );
                 
      system1: System
        port map(
                 CLOCK => C,
                 RESET => RST,
                 start => temps,
                 en_r => tempr,
                 en_w => tempw,
                 en_i => tempi,
                 y0(3 downto 0)  => leds(3 downto 0),
                 bot_read => bot_r
                );
     
     str: process(C)
        begin
            if(C'event and C = '1') then
                if(RST = '1') then 
                    temps <= '0'; 
                end if;
                if(bot_s = '1') then 
                    temps <= '1'; 
                end if;
            end if;
        end process;

end Structural;
