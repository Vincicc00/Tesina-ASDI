library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- il progetto utilizza un clock divider
entity molt_booth is
	 port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   --stop: out std_logic;	--a che serve?   
		   P: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic);
end molt_booth;

architecture structural of molt_booth is
	component unita_controllo is 
		port( q0, q1 ,clock, reset, start: in std_logic;
		  count: in std_logic_vector(3 downto 0);
		  loadM, count_in, loadAQ, en_shift: out std_logic;
		  selAQ, subtract, stop_cu: out std_logic); 
	end component;
	
	component unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);--moltiplicatore e moltiplicando
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
		  count: out std_logic_vector(3 downto 0);
		  P: out std_logic_vector(16 downto 0);
		  q1: out std_logic);
	end component;
	
	
	signal tempq0  ,temp_selM, temp_selAQ, temp_clock, temp_sub,temp_loadAQ: std_logic;
	signal temp_count: std_logic_vector(3 downto 0);
	signal temp_p: std_logic_vector(16 downto 0);
	signal temp_count_in, t_load_add: std_logic;
	signal fine_conteggio: std_logic;
	signal temp_shift, temp_fshift: std_logic;
	signal temp_loadM: std_logic;
	signal temp_stop_cu: std_logic; -- segnale di reset generato dalla UC
	signal temp_reset_in: std_logic; -- segnale di reset in ingresso alla UO
	signal tempq1 : std_logic :='0';
	begin
	
	UC: unita_controllo port map
	(tempq0, tempq1 ,clock, reset, start, 
	temp_count, 
	temp_loadM, temp_count_in, temp_loadAQ, temp_shift, 
	temp_selAQ, temp_sub, temp_stop_cu);
	
	
	UO: unita_operativa port map
	(X, Y, clock, reset, temp_loadAQ, temp_shift, temp_loadM, 
	temp_sub, temp_selAQ, temp_count_in, temp_count, temp_p, tempq1); 
	
	
	tempq0<= temp_p(1);  
	P<=temp_p(16 downto 1);
	
	stop_cu <= temp_stop_cu;
	end structural;