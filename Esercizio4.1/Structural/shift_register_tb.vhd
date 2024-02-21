library ieee;
use ieee.std_logic_1164.all;

entity shift_register_tb is
end shift_register_tb;

architecture tb of shift_register_tb is

    component shift_register
        port (CLK : in std_logic;
              RST : in std_logic;
              EO,EI  : in std_logic;
              SO  : out std_logic;
              s : in std_logic;
              Y  : in std_logic);
    end component;

    signal clk_tb : std_logic;
    signal input_r  : std_logic :='0';
    signal input_l : std_logic :='0';
    signal output  : std_logic;
    signal rst : std_logic;
    signal s : std_logic;  -- s = 0 sposto a sinistra s = 1 sposto a destra
    signal Y : std_logic;  -- Y = 0  sposto di uno    Y = 1 soposto di due


    constant clk_period : time := 20 ns; 

begin
    -- Clock generation
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
   
    uut : shift_register
    port map (CLK => clk_tb,
              RST => rst,
              EO => input_r,
              EI => input_l,
              SO  => output,
              s => s,
              Y => Y);
              
    stimuli : process
    begin
        
        rst <= '1';
        Y <= '1';
        s <= '1';
        wait for 50ns;  --global reset
       
        rst <='0';
        input_l <= '1';
        input_r <= '1';
        
        wait for 140ns;
        s <= '0';
        
        wait;
    end process;

end tb;
