library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Cronometro_tb is

end Cronometro_tb;

architecture Behavioral of Cronometro_tb is

    component Cronometro 
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
    end component;
    
    
    signal clk_tb: std_logic:= '0';                          
    signal sRESET: std_logic:= '0';                          
    signal sSet: std_logic:= '0';
    signal in_seconds: std_logic_vector(5 downto 0):= (others=>'0');                                                                    
    signal in_minutes: std_logic_vector(5 downto 0):= (others=>'0');             
    signal in_hours: std_logic_vector(4 downto 0):= (others=>'0');           
    signal out_seconds: std_logic_vector(5 downto 0):= (others=>'0');                                                                    
    signal out_minutes: std_logic_vector(5 downto 0):= (others=>'0');             
    signal out_hours: std_logic_vector(4 downto 0):= (others=>'0');
    
    signal clk_period: time := 20ns;
    
begin
      
    clk_process : process
        begin
		  clk_tb <= '0';
		  wait for clk_period/4;
		  clk_tb <= '1';
		  wait for clk_period/4;
    end process;
    
    uut: cronometro
      port map(
               clk_tb,
               sReset,
               sSet,
               in_seconds,
               in_minutes,
               in_hours,
               out_seconds,
               out_minutes,
               out_hours
      );
    
    test: process
        begin
        sRESET<='1';
        wait for 100ns;
        sRESET<='0';
        wait for 50ns;
        in_seconds<="011000";
        in_minutes<="111011";
        in_hours<="10110";
        sSet<='1';
        wait for 10ns;
        sSet<='0';
        wait;
     end process;


end Behavioral;
