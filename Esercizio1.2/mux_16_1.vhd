library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1 is 
	port(	
	        c : in std_logic_vector(0 to 15);
			s : in std_logic_vector(0 to 3);
			y0 : out STD_LOGIC
		);		
end mux_16_1;


architecture structural of mux_16_1 is
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
    signal u2 : STD_LOGIC := '0';
    signal u3 : STD_LOGIC := '0';

	component mux_4_1
		port(	b0 	: in STD_LOGIC;
				b1 	: in STD_LOGIC;
				b2  : in STD_LOGIC;
            	b3  : in STD_LOGIC;
                s0 	: in STD_LOGIC;
                s1    : in STD_LOGIC;
				y0 	: out STD_LOGIC
			);	
	end component;

	begin
		mux0: mux_4_1 
			Port map(	
			            c(0),
						c(1),
                        c(2),
                        c(3),
					    s(0),
						s(1),
						u0
					);
		mux1: mux_4_1
			Port map(	
			            c(4),
						c(5),
                        c(6),
                        c(7),
					    s(0),
						s(1),
						u1
					);

        mux2: mux_4_1 
			Port map(	
			            c(8),
						c(9),
                        c(10),
                        c(11),
					    s(0),
						s(1),
						u2
					);

        mux3: mux_4_1 
			Port map(	
			            c(12),
						c(13),
                        c(14),
                        c(15),
					    s(0),
						s(1),
						u3
					);
		
		mux4: mux_4_1
			Port map(	
			            u0,
						u1,
						u2,
						u3,
						s(2),
						s(3),
					    y0
				);
end structural;