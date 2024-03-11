library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaControlloB is port(
	clock:in std_logic;
	reset:in std_logic;
	stop:in std_logic;
	encont:out std_logic;
	rda: in std_logic;
	rd:out std_logic;
	write: out std_logic
	);
end UnitaControlloB;

architecture behavioral of UnitaControlloB is

type state is (idle, scrivi, rdset, conta, fine);
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
			
	main: process(current_state,rda)
			begin
			
			case current_state is
				when idle=>
				    rd<='0';
					encont<='0';
					if rda='1' then
						next_state<=scrivi;
				    else
					   next_state<=idle;
				    end if;
					
				when scrivi => 
				    write <='1';
					next_state<=rdset;
				
				when rdset => 
				    write <= '0';
				    rd<='1';
				    next_state<=conta; 
				
				when conta=>
				    rd<='0';
				    if stop='1' then
						next_state<=fine;
					else
						encont<='1';
						next_state<=idle;
					end if;
							
				when fine=> next_state<=fine;
			end case;
				
			end process;
		
	end behavioral;
						
						