
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_A is
    Generic(
            M: integer := 7;
            N: integer := 3
           );
    Port (
          clock: in std_logic;
          reset: in std_logic;
          ACK: in std_logic;
          dato: out std_logic_vector(M downto 0);
          strobe : out std_logic
          );
end Sistema_A;

architecture Structural of Sistema_A is
    component CU_A
        Port (
              clock: in std_logic;
              reset: in std_logic;
              strobe: out std_logic;
              ACK: in std_logic;
              read: out std_logic;
              enable_count: out std_logic
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
    
    component counter
        generic(
                N : integer := 3   -- questo ci da la lunghezza del vector, il numero di bit
               );
        Port (
              CLK : in std_logic;
              RESET: in std_logic;
              enable: in std_logic;
              y: out std_logic_vector(N downto 0) -- uscita contatore
             );
     end component;
     
     signal t_strobe: std_logic;
     signal t_read: std_logic;
     signal t_enable_count: std_logic;
     signal t_address: std_logic_vector(3 downto 0);
     
begin
    
      CU: CU_A
        port map(
                 clock => clock,
                 reset => reset,
                 strobe => strobe,
                 ACK => ACK,
                 read => t_read,
                 enable_count => t_enable_count
                );
      
      rom_x: ROM
        port map(
                 CLK => clock,
                 RST => reset,
                 address => t_address,
                 dout => dato,
                 read => t_read
                );
                
      cont: counter
        generic map(
                     3
                    )
        port map(
                 CLK => clock,
                 RESET => reset,
                 enable => t_enable_count,
                 y => t_address
                );           
    
end Structural;
