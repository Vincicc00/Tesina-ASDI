
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity System is
    generic(
            M: integer := 7;
            N: integer := 3
          );
    Port (
          CLK: in std_logic;
          RST: in std_logic;
          uscita: inout std_logic_vector(M+1 downto 0)
         );
end System;

architecture Structural of System is
    
    component Sistema_A
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
     end component;
     
     component Sistema_B
        Generic(
                M: integer := 7;
                N: integer := 3
              );
        Port (
              clock: in std_logic;
              reset: in std_logic;
              ACK: out std_logic;
              dato: in std_logic_vector(M downto 0);
              strobe : in std_logic;
              usc: inout std_logic_vector(M+1 downto 0)
             );   
    end component;
    
    signal t_dato: std_logic_vector(7 downto 0);
    signal t_strobe,t_ACK: std_logic;
   
begin
     
     S_A: Sistema_A
        generic map(
                    7,
                    3
                   )
        port map(
                 clock => CLK, 
                 reset => RST,
                 ACK => t_ACK,
                 dato => t_dato,
                 strobe => t_strobe
                );
     
     S_B: Sistema_B
        generic map(
                    7,
                    3
                   )
         port map(
                  clock => CLK,
                  reset => RST,
                  ACK => t_ACK,
                  dato => t_dato,
                  strobe => t_strobe,
                  usc => uscita
                 );
                

end Structural;
