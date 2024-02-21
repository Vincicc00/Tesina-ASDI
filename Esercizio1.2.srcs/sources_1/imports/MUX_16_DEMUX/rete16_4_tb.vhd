
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rete16_4_tb is

end rete16_4_tb;

architecture behavioral of rete16_4_tb is

	component rete16_4
	   Port (
            i : in std_logic_vector(0 to 15);
            sel1 : in std_logic_vector(0 to 3);
            sel2 : in std_logic_vector(0 to 1);
            o : out std_logic_vector(0 to 3)
           );
	end component;

	signal input 	: STD_LOGIC_VECTOR (0 to 15) 	:= (others => '0');
	signal control 	: STD_LOGIC_VECTOR (0 to 3) := (others => '0');
	signal control2 : STD_LOGIC_VECTOR (0 to 1) := (others => '0');
	signal uscita: std_logic_vector(0 to 3) := (others => '0');


	begin

		uut: rete16_4
			Port map(	
			          input(0 to 15),
			          control(0 to 3),
			          control2(0 to 1),
			          uscita(0 to 3)
					);

		stim_proc: process
		begin
		
		wait for 100 ns;
		
		--input = b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15
		--control = s3 s2 s1 s0  e control2 = s0 s1
		
		input 	<= "1010101010101010";

		control <= "0000";
		control2 <= "00"; 
		wait for 10 ns; -- si alza uscita(0)

		control <= "0001";
		control2 <= "01"; 
		wait for 10 ns; -- si alza uscita(1) 

		control <= "0010";
		control2 <= "10"; 
		wait for 10 ns; -- si alza uscita(2) 

		control <= "0011";
		control2 <= "11"; 
		wait for 10 ns; --si alza uscita(3)
		
		control <= "1100";
		control2 <= "00";
		wait for 10 ns; -- non si alza nulla

		wait;
		end process;
end; 

