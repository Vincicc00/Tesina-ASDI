library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistemaAB is port (
	reset:in std_logic;
	start:in std_logic;
	clock:in std_logic
	);
end sistemaAB;

architecture structural of sistemaAB is

component sistemaA is port(
	clock:in std_logic;
	reset:in std_logic;
	start:in std_logic;
	serial:out std_logic
	);
end component;

component sistemaB is port(
	clock:in std_logic;
	reset:in std_logic;
	serial:in std_logic);
end component;
	
signal AtoB: std_logic;

begin
	a: SistemaA port map(
		clock=>clock,
		reset=>reset,
		start=>start,
		serial=>AtoB
	);
	
	b: SistemaB port map(
		clock=>clock,
		reset=>reset,
		serial=>AtoB
		);
		
end structural;

