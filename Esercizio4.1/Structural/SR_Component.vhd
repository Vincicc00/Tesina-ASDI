
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SR_Component is
    generic (n: integer := 9);
    Port (
           CLK : in std_logic;
           RST : in std_logic;
           a1,a2,b1,b2 : in std_logic;
           O : out std_logic;
           s : in std_logic;
           Y : in std_logic  );
end SR_Component;

architecture Structural of SR_Component is
    Component FF_D
        Port (  
            CLK : in std_logic;
            RST : in std_logic;
            d : in std_logic;
            q : out std_logic 
          );
    end Component;
    
    Component mux_2_1
        Port( 	
	        a0 	: in STD_LOGIC;
			a1 	: in STD_LOGIC;
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	       );
    end Component;
    
    signal output1 : std_logic := '0'; 
    signal output2 : std_logic := '0';
    signal output3 : std_logic := '0';

begin
    
    
    
    mux1: mux_2_1 port map(
        a1,
        a2,
        s,
        output1
     );
     
     mux2: mux_2_1 port map(
        b1,
        b2,
        s,
        output2
      );
      
      mux3: mux_2_1 port map(
        output1,
        output2,
        Y,
        output3
      );
      
      ff: FF_D port map(
        CLK,
        RST,
        output3,
        O
    );
       
end Structural;
