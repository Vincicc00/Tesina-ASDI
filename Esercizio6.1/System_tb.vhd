library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System_tb is
end System_tb;

architecture Behavioral of System_tb is
    component System
        Port (
          CLOCK: in std_logic;
          RESET: in std_logic;
          start: in std_logic; 
          en_r: inout std_logic;
          en_w: inout std_logic;
          en_i: inout std_logic;
          y0: inout std_logic_vector(3 downto 0)
         );
     end component;
     
     signal clk_tb: std_logic:= '0';                          
     signal tRESET: std_logic:= '0'; 
     signal tstart : std_logic:='0';
     signal tread: std_logic;
     signal twrite: std_logic;
     signal tinput: std_logic;
     signal ty0: std_logic_vector(3 downto 0):=(others=>'0');

     signal clk_period: time := 20ns;
begin
    clk_process : process
        begin
		  clk_tb <= '0';
		  wait for clk_period/4;
		  clk_tb <= '1';
		  wait for clk_period/4;
    end process;
    
    uut: system
        port map(
                 clk_tb,
                 tReset,
                 tstart,
                 tread,
                 twrite,
                 tinput,
                 ty0
                );
     test: process
        begin
            tReset <= '1';
            wait for 20ns;
            tReset <= '0';
            tstart <= '1';
            wait for 150ns;
            tReset <='1';
            wait;
        end process;

end Behavioral;
