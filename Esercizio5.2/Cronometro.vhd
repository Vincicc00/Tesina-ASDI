library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro is
    Port (
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
end Cronometro;

architecture Structural of Cronometro is
    
    component clock_filter
        generic(
			    CLKIN_freq : integer := 100000000; --clock board 100MHz
			    CLKOUT_freq : integer := 1       --frequenza desiderata 1Hz
			   );
        Port ( 
              clock_in : in  STD_LOGIC;
		      reset : in STD_LOGIC;
              clock_out : out  STD_LOGIC -- attenzione: non � un vero clock ma un impulso che sar� usato come enable
             );
    end component; 
    
    component counter
        generic(
                 m : integer := 8;
                 n : integer := 3
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
    end component;
    
    signal enable_s : std_logic:= '0';
    signal count_s : std_logic :='0';
    signal enable_m : std_logic:= '0';
    signal count_m : std_logic :='0';
    signal enable_h : std_logic:= '0';
    signal count_h : std_logic :='0';
begin
    
    fr: clock_filter
        generic map(
                    100000000,
                    1
                   )
        port map(
                 clock_in => CLOCK,
                 reset => RST,
                 clock_out => enable_s
                );
      
    counter_s: counter
        generic map(
                    60,
                    6
                   )
         port map(
                  CLK => CLOCK,
                  RESET => RST,
                  enable => enable_s,
                  load => set,
                  data => seconds_in,
                  y => seconds_out,
                  count => count_s
                 );
                 
        enable_m <= count_s and enable_s;
        counter_m: counter
        generic map(
                    60,
                    6
                   )
         port map(
                  CLK =>CLOCK,
                  RESET => RST,
                  enable => enable_m,
                  load => set,
                  data => minutes_in,
                  y => minutes_out,
                  count => count_m
                 );
                 
        enable_h <= count_m and enable_m and enable_s;
        counter_h: counter
        generic map(
                    24,
                    5
                   )
         port map(
                  CLK =>CLOCK,
                  RESET => RST,
                  enable => enable_h,
                  load => set,
                  data => hours_in,
                  y => hours_out,
                  count => count_h
                 );

end Structural;
