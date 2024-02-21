library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- DEMUX 1:2 --

entity demux_1_2 is

	port( 	b0 	: in STD_LOGIC;
			s0	: in STD_LOGIC;
			y0 	: out STD_LOGIC;
			y1 	: out STD_LOGIC
	);
		
end demux_1_2;


architecture dataflow of demux_1_2 is

	begin
		
		y0 <= b0 and (not s0);
		y1 <= b0 and s0;

end dataflow;
