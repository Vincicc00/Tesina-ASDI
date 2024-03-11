library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SistemaAB_tb is
end SistemaAB_tb;

architecture behavioral of SistemaAB_tb is

  component SistemaAB is
    port (
      start  : in std_logic;
      reset  : in std_logic;
      clock:in std_logic
    );
  end component;

  signal WR : std_logic;
  signal reset : std_logic;
  signal clock : std_logic;
begin

  sistema_AB: SistemaAB port map (
    reset => reset,
    start => WR,
    clock =>clock
  );
 
  
  clk_pr: process
  begin
      clock <= '0';
      wait for  1ns;
      clock <= '1';
      wait for 1ns;
      
  end process;


  process
  begin
    
    reset <= '1';
	wait for 10ns;
    reset <= '0';
    WR <= '1'; 
	wait for 100ns;
    wait;
  end process;


end behavioral;
