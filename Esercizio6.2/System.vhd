
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
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
end System;

architecture Structural of System is
    
    component ControlUnit
        Port(
              CLK: in std_logic;
              RST: in std_logic; 
              start: in std_logic;
              en_input: inout std_logic;
              en_read: inout std_logic;
              en_write: inout std_logic;
              bot_read: in std_logic
             );
    end component;
    
    component Counter
         generic(
                  n : integer := 4
                );
          port(
                CLK : in std_logic;
                RESET: in std_logic;
                enable: in std_logic;
                load: inout std_logic;
                data: in std_logic_vector(n-1 downto 0);
                y: out std_logic_vector(n-1 downto 0) -- uscita contatore
              );
      end component;
      
      component ROM
        port(
             CLK : in std_logic;
             RST: in std_logic;
             address : in  std_logic_vector(3 downto 0);
             dout    : out std_logic_vector(7 downto 0);
             read : in std_logic
            );
      end component;
      
      component Macchina_M
          port(
                input   : in  std_logic_vector(7 downto 0);
                output  : out std_logic_vector(3 downto 0)
              );
       end component;
       
       component MEM
            Port (
                  CLK : in std_logic;
                  RST: in std_logic;
                  input : in std_logic_vector(3 downto 0);
                  address: in std_logic_vector(3 downto 0);
                  write : in std_logic
                 );
        end component;  
        
        signal tempinput: std_logic:='0';
        signal tempread: std_logic:='0';
        signal tempwrite: std_logic:='0';
        signal tempind: std_logic_vector(3 downto 0):=(others => '0');
        signal temploc: std_logic_vector(7 downto 0):=(others => '0');
        signal tempy0: std_logic_vector(3 downto 0):=(others => '0'); 
        signal tload: std_logic:='1';
begin

      CU: ControlUnit
            port map(
                      CLOCK,  
                      RESET,
                      start,
                      en_i,
                      en_r,
                      en_w,
                      bot_read
                     );
      counter_a: Counter
        generic map(
                    4
                   )
        port map(
                 CLOCK,
                 RESET,
                 en_i,
                 tload,
                 "1111",
                 tempind
                );
                
        ROM_16: ROM
            port map(
                     CLOCK,
                     RESET,
                     tempind,  
                     temploc,  
                     en_r
                    );
                    
         macchina: Macchina_M
                port map(
                         temploc,     
                         tempy0       
                        );
                  --loc <= temploc;
          memoria: MEM
                port map(
                         CLOCK,
                         RESET,
                         tempy0, 
                         tempind,    
                         en_w
                        );
           y0 <= tempy0;   

end Structural;
