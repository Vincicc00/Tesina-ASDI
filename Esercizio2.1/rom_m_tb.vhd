
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rom_m_tb is

end rom_m_tb;

architecture behavioral of rom_m_tb is

	component system_S
	    port(
             address : in  std_logic_vector(3 downto 0);
             y    : out std_logic_vector(3 downto 0)
            );
        end component;

	signal input_address	: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal output_fin   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	
	begin
	    
	    uut: system_S
	       port map(
	                input_address,
	                output_fin
	               );
    	   
		stim_proc: process
		begin
		
		wait for 100 ns;
			
		input_address	<= "0001";
		wait for 10 ns; -- in uscita ho l'elemento numero 1 in memoria che vale 1 ma concatenando i bit avrò 0
		
		input_address  <= "0010"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 2 in memoria che vale 2 ma concatenando i bit avrò 1
		
		input_address  <= "0011"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 3 in memoria che vale 3 ma concatenando i bit avrò 1

		input_address  <= "0100"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 4 in memoria che vale 4 ma concatenando i bit avrò 0

		input_address  <= "0101"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 5 in memoria che vale 5 ma concatenando i bit avrò 0

		input_address  <= "0110"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 6 in memoria che vale 6 ma concatenando i bit avrò 1

		input_address  <= "0111"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 7 in memoria che vale 7 ma concatenando i bit avrò 1

		input_address  <= "1000"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 8 in memoria che vale 8 ma concatenando i bit avrò 2 

		input_address  <= "1001"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 9 in memoria che vale 9 ma concatenando i bit avrò 2

		input_address  <= "1010"; 
		wait for 10 ns; -- in uscita ho l'elemento numero 10 in memoria che vale 42 ma concatenando i bit avrò 7

		input_address  <= "1111";
		wait for 10 ns; -- in uscita ho l'elemento numero 15 (l'ultimo) in memoria che vale 15 ma concatenando i bit avrò 3

		wait;
		end process;
end; 

