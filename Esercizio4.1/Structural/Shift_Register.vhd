
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Register is
    generic ( n: integer := 9);
    port(CLK, RST : in std_logic;
         EO, EI  : in std_logic;  
         SO  : out std_logic;
         s : in std_logic;      -- segnale di abilitazione per shfit sinistra o destra
         Y: in std_logic);      -- segnale di abilitazione per spostare 1 o 2 posizioni
end Shift_Register;

architecture Structural of Shift_Register is

Component SR_Component 
     port(
        CLK, RST : in std_logic;
        a1, a2, b1, b2 : in std_logic;
        s : in std_logic ;
        Y : in std_logic; 
        O : out std_logic
        );
end Component;

signal tempY : std_logic_vector (n-1 downto 0) := (others => '0');
begin 
    cp_last: SR_Component port map(
        CLK , RST,
        EO, tempY(n-2),
        '0', tempY(n-3),
        s, 
        Y,
        tempY(n-1)
    );
    cp_last_1: SR_Component port map(
        CLK , RST,
        tempY(n-1), tempY(n-3),
        EO , tempY(n-4),
        s, 
        Y,
        tempY(n-2)
    );
    
    cp_last_3_to_2: for i in n-3 downto 2 generate 
        comp:SR_Component  port map(
            CLK, RST,
            tempY(i+1),tempY(i-1),
            tempY(i+2), tempY(i-2),
            s,
            Y,
            tempY(i)
        
        );
     end generate;
     cp_second: SR_Component port map(
        CLK , RST,
        tempY(2), tempY(0),
        tempY(3), EI ,
        s, 
        Y,
        tempY(1)
    );
    cp_first: SR_Component port map(
        CLK , RST,
        tempY(1) , EI ,
        tempY(2) , '0',
        s, 
        Y,
        tempY(0)
    );
      SO <= tempY(0) when s='0' else
            tempY(n-1);
     
end Structural;