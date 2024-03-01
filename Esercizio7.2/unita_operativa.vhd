library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);--moltiplicatore e moltiplicando
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
		  count: out std_logic_vector(3 downto 0);
		  P: out std_logic_vector(16 downto 0);
		  q1: out std_logic);
end unita_operativa;

architecture structural of unita_operativa is

	component adder_sub is
	port( X, Y: in std_logic_vector(7 downto 0);
		  cin: in std_logic;
		  Z: out std_logic_vector(7 downto 0);
		  cout: out std_logic);		  
	end component;
	
	component registro8 is 
		port( A: in std_logic_vector(7 downto 0);
		  clk, res, load: in std_logic;
		  B: out std_logic_vector(7 downto 0));
	end component;
	
	
	component mux_21 is
	generic (width : integer range 0 to 20 := 17);
	port( x0, x1: in std_logic_vector(width-1 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(width-1 downto 0));
	end component;
	
	
	component shift_register is
	port( parallel_in: in std_logic_vector(16 downto 0);
	      serialIn: in std_logic;
		  clock, reset, load, shift: in std_logic;
		  parallel_out: out std_logic_vector(16 downto 0);
		  q1: out std_logic);	  
	end component;
	
	component cont_mod16 is
	port( clock,  reset: in std_logic;
		  count_in: in std_logic;
		  count: out std_logic_vector(3 downto 0));
	end component;


	signal Mreg: std_logic_vector(7 downto 0); --segnale temporaneao tra reg8 M e mux 21
	signal op2: std_logic_vector(7 downto 0); --segnale temporaneo di uscita dal multiplexer tra mux e adder
	signal AQ_init: std_logic_vector(16 downto 0); --segnale in input all'SR 
	signal AQ_in: std_logic_vector(16 downto 0); --segnale in input all'SR 
	signal AQ_out: std_logic_vector(16 downto 0); --segnale temporaneo uscita dell'SR
	signal sum: std_logic_vector(7 downto 0); --uscita del parallel adder 
	signal AQ_sum_in : std_logic_vector(16 downto 0); 
	signal riporto: std_logic; -- riporto in uscita dell'adder che non utilizziamo
	signal  SRserialIn: std_logic;
	signal tempq1: std_logic:='0';
	
begin
	
	--1)registro moltiplicando
	M: registro8 port map(Y, clock, reset, loadM, Mreg);
	
    AQ_init <= "00000000" & X & '0';  --valore da inserire all'inizio nello shift register
    
    AQ_sum_in <=sum & AQ_out(8 downto 0);  
    --2) mux per load SR
    MUX_SR_parallel_in : mux_21 generic map (width => 17) port map(AQ_init, AQ_sum_in, selAQ, AQ_in);
    
	SRserialIn <= AQ_out(16);
    	
	-- 3) shift register A.Q
	SR: shift_register port map(AQ_in, SRserialIn ,clock, reset, loadAQ, shift, AQ_out, tempq1);
	
	-- 4) sommatore
	ADD_SUB: adder_sub port map(AQ_out(16 downto 9), Mreg, sub, sum, riporto);
	
	-- 5) contatore
	CONT: cont_mod16 port map(clock, reset, count_in, count);
	
	P<=AQ_out;
	q1 <= tempq1;

end structural;
