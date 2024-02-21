library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rete16_4 is
    Port (
            i : in std_logic_vector(0 to 15);
            sel1 : in std_logic_vector(0 to 3);
            sel2 : in std_logic_vector(0 to 1);
            o : out std_logic_vector(0 to 3)
           );
end rete16_4;

architecture Structural of rete16_4 is
    
    component mux_16_1
        port(	
	        c : in std_logic_vector(0 to 15);
			s : in std_logic_vector(0 to 3);
			y0 : out std_logic
		    );
    end component;
    
    component demux_1_4
        port(	
                f0 : in STD_LOGIC;
			    s0 : in STD_LOGIC;
			    s1 : in STD_LOGIC;
                k1 : out STD_LOGIC;
			    k2 : out STD_LOGIC;
			    k3 : out STD_LOGIC;
			    k4 : out STD_LOGIC
		);		
    end component;
    
    signal u3: std_logic := '0';
begin
    mux: mux_16_1
        port map(
                 i(0 to 15),
                 sel1(0 to 3),
                 u3
                 );
    
    demux: demux_1_4
        port map(
                 u3,
                 sel2(0),
                 sel2(1),
                 o(0),
                 o(1),
                 o(2),
                 o(3)
                );

end Structural;
