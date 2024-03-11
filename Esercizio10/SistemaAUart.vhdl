library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sistemaA is port (
	clock:in std_logic;
	reset:in std_logic;
	start:in std_logic;
	serial:out std_logic
	);
end sistemaA;

architecture structural of sistemaA is

signal stop: std_logic;
signal indirizzo: std_logic_vector(2 downto 0);
signal encont: std_logic;
signal dato: std_logic_vector(7 downto 0);
signal read: std_logic;
signal tbe:std_logic;
signal wr:std_logic;

component UnitaControlloA port(
	clock:in std_logic;
	reset:in std_logic;
	start:in std_logic;
	stop:in std_logic;
	encont:out std_logic;
	wr: out std_logic;
	tbe:in std_logic;
	read: out std_logic
	);
end component;

component ROM is 
    port(
        CLK : in std_logic;
        address : in  std_logic_vector(2 downto 0);
        dout    : out std_logic_vector(7 downto 0);
        read : in std_logic
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


begin

	r: ROM 
	   port map(
		CLK=>clock,
		address=>indirizzo,
		dout=>dato,
		read => read);
	
	contA: counter 
	   port map(
		CLK=>clock,
		RST=>reset,
		enable=>encont,
		y=>indirizzo
		);
		
	UC: UnitaControlloA 
	   port map(
		clock=>clock,
		reset=>reset,
		start=>start,
		stop=>stop,
		encont=>encont,
		wr=>wr,
		tbe=>tbe,
		read=>read);
		
	ua: UART 
	   port map(
		TXD=>serial,
		RXD=>'1',
		CLK=>clock,
		DBIN=>dato,
		TBE=>tbe,
		WR=>wr,
		RD=>'1',
		RST=>reset);
		
end structural;
		