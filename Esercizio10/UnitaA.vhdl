library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaControlloA is port(
	clock:in std_logic;
	reset:in std_logic;
	start:in std_logic;
	stop:in std_logic;
	encont:out std_logic;
	wr: out std_logic;
	tbe: in std_logic;
	read: out std_logic
	);
end UnitaControlloA;

architecture behavioral of UnitaControlloA is

type state is (idle,leggi,conta,trasmetti,attesa,fine);
signal current_state,next_state: state;

begin

	regstato: process(clock)
			begin
			if(clock'event and clock='1') then
				if(reset='1') then 
					current_state<=idle;
				else
					current_state<=next_state;
				end if;
			end if;
			end process;
			
	main: process(current_state,start,stop,tbe)
			begin
			
			case current_state is
				when idle => 
				    read<='1';
                    if start='1' then
                        next_state<=leggi;
                    else
                        next_state<=idle;
                    end if;
				
				when leggi=>
				    encont<='0';
					read<='1';
					next_state<=trasmetti;
				
				when trasmetti=>
				    wr<='1';
				    read<='0';
					if tbe<='0' then
						next_state<=attesa;
					else
						next_state<=trasmetti;
					end if;
					
				when attesa=> 
				    wr<='0';
				    if tbe='1'then
							next_state<=conta;
					else
							next_state<=attesa;
					end if;
				
				when conta=> 
				    if tbe<='1' then
                        if stop='1' then
                            next_state<=fine;
                        else
                            encont<='1';
                            next_state<=leggi;
                        end if ;
                    else
                        next_state<=conta;
                    end if;
							
				when fine=> next_state<=fine;
				end case;
			end process;
		
	end behavioral;
						
						
						
						