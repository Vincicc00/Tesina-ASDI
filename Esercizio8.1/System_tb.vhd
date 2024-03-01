
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity System_tb is
end System_tb;

architecture Behavioral of System_tb is
    component System
        generic(
                M: integer := 7;
                N: integer := 3
               );
        Port (
              CLK: in std_logic;
              RST: in std_logic;
              uscita: inout std_logic_vector(M+1 downto 0)
             );
    end component;
    
    signal clock: std_logic;
    signal reset: std_logic;
    constant clk_period : time := 10 ns;
    signal end_sim : std_logic := '0';
    signal somma: std_logic_vector(8 downto 0);
begin
    
    uut: System
        generic map(
                    7,
                    3
                   )
         port map(
                  CLK => clock,
                  RST => reset,
                  uscita => somma
                 );
    
    
    clk_process : process
     begin
        while (end_sim = '0') loop
            clock<= '1';
            wait for clk_period/2;
            clock <= '0';
            wait for clk_period/2;
        end loop;
        wait;
     end process;
     
     sim: process
        begin
            reset <= '1';
            wait for 60ns;
            reset <= '0';
            
            
            
          wait;
        end process;

end Behavioral;
