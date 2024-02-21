library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Definizione dell'interfaccia del modulo demux_1_4.
entity demux_1_4 is 
	port(	f0 : in STD_LOGIC;
			s0 : in STD_LOGIC;
			s1 : in STD_LOGIC;
            k1 : out STD_LOGIC;
			k2 : out STD_LOGIC;
			k3 : out STD_LOGIC;
			k4 : out STD_LOGIC
		);		
end demux_1_4;

-- Definizione architettura del modulo demux_1_4 con una descrizione strutturale.
architecture structural of demux_1_4 is
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';

	component demux_1_2
		port(	b0 	: in STD_LOGIC;
				s0 	: in STD_LOGIC;
                y0  : out STD_LOGIC;
				y1 	: out STD_LOGIC
			);	
	end component;

	begin
		demux0: demux_1_2
			Port map(	b0 	=> f0,
						s0	=> s0,
                        y0  => u0,
						y1 	=> u1
					);
		demux1: demux_1_2
			Port map(	b0 	=> u0,
						s0	=> s1,
						y0 	=> k1,
						y1	=> k2
					);
		demux2: demux_1_2
			Port map(	b0 	=> u1,
						s0	=> s1,
						y0 	=> k3,
						y1	=> k4
				);
end structural;