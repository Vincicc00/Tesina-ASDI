library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro_Board is
    Port (
          CLOCK: in std_logic;
          RST: in std_logic;
          enable_data: in std_logic; -- ci serve per caricare tutto il cornometro contemporaneamente
          switches: in std_logic_vector(5 downto 0); -- ci servono per 
          LOAD: in std_logic;
          anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		  cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0);
		  bot_int: in std_logic;
		  bot_vis: in std_logic;
		  V10: in std_logic
         );
end Cronometro_Board;

architecture Structural of Cronometro_Board is
    
    component ButtonDebouncer
        generic (                       
                 CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
                 btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                            -- il valore di default è 10 millisecondi
                );
         Port ( 
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC
              );
      end component;
      
      component Acquisizione
        Port (
              CLK: in std_logic;
              RST: in std_logic;
              load: in std_logic;
              dato_s: out std_logic_vector(5 downto 0);  
              dato_m: out std_logic_vector(5 downto 0);  
              dato_h: out std_logic_vector(4 downto 0);
              data: in std_logic_vector(5 downto 0)
             );
      end component;
      
      
      component Cronometro
        Port(
              CLOCK: in std_logic;
              RST: in std_logic;
              set: in std_logic;
              seconds_in: in std_logic_vector(5 downto 0);
              minutes_in: in std_logic_vector(5 downto 0);
              hours_in : in std_logic_vector(4 downto 0);
              seconds_out: out std_logic_vector(5 downto 0);
              minutes_out: out std_logic_vector(5 downto 0);
              hours_out : out std_logic_vector(4 downto 0)
            );
       end component;    
       
       component Encoder
            Port(
                 secondi : in STD_LOGIC_VECTOR(5 downto 0);
                 minuti: in STD_LOGIC_VECTOR(5 downto 0);
                 ore: in STD_LOGIC_VECTOR(4 downto 0);
                 Y : out STD_LOGIC_VECTOR(31 downto 0)
                );        
        end component;
        
        component display_seven_segments
            Generic( 
				    CLKIN_freq : integer := 100000000; 
				    CLKOUT_freq : integer := 1
				   );
            Port ( 
                  CLK : in  STD_LOGIC;
                  RST : in  STD_LOGIC;
                  VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
                  ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
                  DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
                  ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
                  CATHODES : out  STD_LOGIC_VECTOR (7 downto 0)
                 );
        end component;
        
        component Intertempi
            generic(
                    n: integer :=4
                   );
            Port (
                  CLK: in std_logic;
                  RST: in std_logic;
                  bot: in std_logic;
                  value: in std_logic_vector(31 downto 0);
                  loc: out std_logic_vector(31 downto 0);
                  bot_v: in std_logic
                );  
        end component; 
        
        signal enable_s : std_logic;
        signal temps: std_logic_vector(5 downto 0);
        signal tempm: std_logic_vector(5 downto 0);
        signal temph: std_logic_vector(4 downto 0);
        signal bot_e: std_logic;
        signal bot_l: std_logic;
        signal sec: std_logic_vector(5 downto 0);
        signal min: std_logic_vector(5 downto 0);
        signal hou: std_logic_vector(4 downto 0); 
        signal Y_cod: std_logic_vector(31 downto 0);
        signal bot_i: std_logic;
        signal bot_vi: std_logic;
        signal Yloc: std_logic_vector(31 downto 0);
        signal uscita: std_logic_vector(31 downto 0);
begin
    
    b_e: ButtonDebouncer
        generic map(
                 10,
                 10000000
                )
         port map(
                  RST => RST,
                  CLK => CLOCK,
                  BTN => enable_data,
                  CLEARED_BTN => bot_e
                 );
    
    b_l: ButtonDebouncer
        generic map(
                 10,
                 10000000
                )
         port map(
                  RST => RST,
                  CLK => CLOCK,
                  BTN => LOAD,
                  CLEARED_BTN => bot_l
                 ); 
                       
    b_int: ButtonDebouncer
        generic map(
                 10,
                 10000000
                )
         port map(
                  RST => RST,
                  CLK => CLOCK,
                  BTN => bot_int,
                  CLEARED_BTN => bot_i
                 );   
    b_v: ButtonDebouncer
        generic map(
                 10,
                 10000000
                )
         port map(
                  RST => RST,
                  CLK => CLOCK,
                  BTN => bot_vis,
                  CLEARED_BTN => bot_vi
                 );   
    acq: Acquisizione
        port map(
                 CLK => CLOCK,
                 RST => RST,
                 load => bot_l,
                 dato_s => temps,
                 dato_m => tempm,
                 dato_h => temph,
                 data =>switches
                );
    
    cr: Cronometro
        port map(
                 CLOCK => CLOCK,
                 RST => RST,
                 set => bot_e,
                 seconds_in => temps,
                 minutes_in => tempm,
                 hours_in => temph,
                 seconds_out => sec,
                 minutes_out => min,
                 hours_out => hou
                );
     
       en: Encoder
            Port map(
                     secondi => sec,
                     minuti => min,
                     ore =>hou,
                     Y => Y_cod
                );        
        
        
        disp: display_seven_segments
            Generic map( 
				    100000000, 
				    500
				   )
            Port map ( 
                  CLK => CLOCK,
                  RST => RST,
                  VALUE => uscita,
                  ENABLE => "00111111", -- decide quali cifre abilitare
                  DOTS => "00010100", -- decide quali punti visualizzare
                  ANODES => anodes_out,
                  CATHODES => cathodes_out
                 );
        
        int: Intertempi
            generic map(
                        4
                       )
            port map(
                     CLK => CLOCK,
                     RST => RST,
                     bot => bot_i,
                     value => Y_cod,
                     bot_v => bot_vi,
                     loc => Yloc
                    );         
                       
     main: process(CLOCK)
     begin 
        if(CLOCK'event and CLOCK = '1') then 
            if(V10 = '1') then
                uscita <= Yloc;
            else 
                uscita <= Y_cod;
            end if;
        end if;
     end process;
            
end Structural;
