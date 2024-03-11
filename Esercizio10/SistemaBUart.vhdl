library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistemaB is port (
	clock:in std_logic;
	reset:in std_logic;
	serial:in std_logic
	);
end sistemaB;

architecture structural of sistemaB is

component UnitaControlloB is port(
	clock:in std_logic;
	reset:in std_logic;
	stop:in std_logic;
	encont:out std_logic;
	rda: in std_logic;
	rd:out std_logic;
	write: out std_logic
	);
end component;

component MEM is 
    Port (
          CLK : in std_logic;
          input : in std_logic_vector(7 downto 0);
          address: in std_logic_vector(2 downto 0);
          write : in std_logic
         );
end component;

component counter is 
    generic(
            n : integer := 3   -- questo ci da la lunghezza del vector, il numero di bit
           );
  Port (
        CLK : in std_logic;
        RST: in std_logic;
        enable: in std_logic;
        y: out std_logic_vector(n-1 downto 0) -- uscita contatore
       );
end component;

component UART is port(
	TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;					
		DBIN 	: in  std_logic_vector (7 downto 0);
		DBOUT : out std_logic_vector (7 downto 0);	
		RDA	: inout std_logic;						
		TBE	: out std_logic 	:= '1';				
		RD		: in  std_logic;					
		WR		: in  std_logic;					
		PE		: out std_logic;					
		FE		: out std_logic;					
		OE		: out std_logic;					
		RST		: in  std_logic	:= '0');
end component;

signal stop: std_logic;
signal indirizzo: std_logic_vector(2 downto 0);
signal encont: std_logic;
signal uartmem:std_logic_vector(7 downto 0);
signal rd:std_logic;
signal read: std_logic;
signal pe:std_logic;
signal fe:std_logic;
signal txd:std_logic;
signal oe:std_logic;
signal rda:std_logic;
signal tbe:std_logic;
signal write:std_logic;


begin

	memoria: MEM 
	   port map(
		CLK=>clock,
		input=>uartmem,
		address=>indirizzo,
		write=>write
		);
	
	contB: counter 
	   port map(
		CLK=>clock,
		RST=>reset,
		enable=>encont,
		y=>indirizzo
		);
		
	UC: UnitaControlloB 
	port map(
		clock=>clock,
		reset=>reset,
		stop=>stop,
		encont=>encont,
		rda=>rda,
		rd=>rd,
		write=>write);
		
		
	ub : UART 
	port map(
		DBOUT=>uartmem,
		RXD=>serial,
		CLK=>clock,
		DBIN=>(others=>'0'),
		TBE=>tbe,
		WR=>'0',
		RD=>rd,
		RDA=>rda,
		RST=>reset);
		
end structural;
		