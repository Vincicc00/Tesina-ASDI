library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Booth_Board is
    Port (
          CLK, RST: in std_logic;
          switches_x: in std_logic_vector(7 downto 0);
          switches_y: in std_logic_vector(7 downto 0);
          start: in std_logic;
          enable_input: in std_logic;
          anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		  cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0) );
end Booth_Board;

architecture Structural of Booth_Board is
    component ButtonDebouncer 
        generic (                       
        CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
        btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                            -- il valore di default è 10 millisecondi
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
     end component; 
     
     component molt_booth
        port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   --stop: out std_logic;	--a che serve?   
		   P: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic);
		end component;
    
    component Converter
        Port (
              P: in std_logic_vector(15 downto 0);
              uscita: out std_logic_vector(31 downto 0)
             );
    end component;
    
    component display_seven_segments is
	   Generic( 
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 500
				);
       Port ( 
             CLK : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
             ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
             DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
             ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
             CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
	signal bot_start: std_logic;
	signal bot_enable: std_logic;
	signal t_stop_cu: std_logic;
	signal x: std_logic_vector(7 downto 0);
	signal y: std_logic_vector(7 downto 0);
	signal temp: std_logic_vector(15 downto 0);
	signal disp: std_logic_vector(31 downto 0);
begin
    
    b_s: ButtonDebouncer
        generic map(
                    10,
                    10000000
                    )
         port map(
                  RST,
                  CLK,
                  start,
                  bot_start
                  );
     b_e: ButtonDebouncer
        generic map(
                    10,
                    10000000
                    )
         port map(
                  RST,
                  CLK,
                  enable_input,
                  bot_enable
                  );
     
     molt: molt_booth
        port map(
                 CLK,RST,bot_start,
                 x,y, temp,
                 t_stop_cu
                 );
      
      conv: Converter
        port map(
                 P => temp,
                 uscita => disp
                );
      display: display_seven_segments
        generic map(
                    100000000,
                    500
                    )
        port map(
                  CLK => CLK,
                  RST => RST,
                  VALUE => disp,
                  ENABLE => "00111111", -- decide quali cifre abilitare
                  DOTS => "00000000", -- decide quali punti visualizzare
                  ANODES => anodes_out,
                  CATHODES => cathodes_out
                 );
      

       
       main: process(CLK)
       begin
        if(CLK'event and CLK = '1') then 
            if(bot_enable = '1') then 
                x <= switches_x;
                y <= switches_y;
            end if;
        end if;
       end process;
end Structural;
