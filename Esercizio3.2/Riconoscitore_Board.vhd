
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Riconoscitore_Board is
    Port (
          CLK: in std_logic;
          RESET: in std_logic;
          S1: in std_logic;   --input 
          S2: in std_logic;   --modo
          B1: in std_logic;   --enable input
          B2: in std_logic;   -- enable modo
          led: out std_logic  -- output
         );
end Riconoscitore_Board;

architecture Structural of Riconoscitore_Board is
    
    
    component ButtonDebouncer
        generic (                       
                 CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
                 btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                          -- il valore di default è 10 millisecondi
                );
        Port( 
             RST : in STD_LOGIC;
             CLK : in STD_LOGIC;
             BTN : in STD_LOGIC;
             CLEARED_BTN : out STD_LOGIC
            );
    end component;
    
    component Riconoscitore_101
        port( 
             i: in std_logic;   --- switch V10
             enable_input: in std_logic;  --bottone P17
             A,RST: in std_logic; -- A = clock  RST = Bottone C12
             M : in std_logic;  --  switch U11
             enable_M: in std_logic;  -- bottone M17
             Y: out std_logic  -- led H17
             --debug: out std_logic
            );
     end component;
     
     signal button1: std_logic;
     signal button2: std_logic;
begin
                
    bot1: ButtonDebouncer  --input
        generic map(
                    10,
                    10000000
                   )
        port map(
                    RST => RESET,
                    CLK => CLK,
                    BTN => B1,
                    CLEARED_BTN => button1
                );
                
    bot2: ButtonDebouncer  --modo
        generic map(
                    10,
                    10000000
                   )
        port map(
                    RST => RESET,
                    CLK => CLK,
                    BTN => B2,
                    CLEARED_BTN => button2
                );
     
     Riconoscitore: Riconoscitore_101
        port map(
                 i => S1,
                 enable_input => button1,
                 A => CLK,
                 RST => RESET,
                 M => S2,
                 enable_M => button2,
                 Y => led
                 --debug => debug
                );

end Structural;
