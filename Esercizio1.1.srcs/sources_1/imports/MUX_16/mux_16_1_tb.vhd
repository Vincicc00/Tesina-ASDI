library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1_tb is

    end mux_16_1_tb;
    
    architecture behavioral of mux_16_1_tb is
    
        component mux_16_1
        
            port (  c0 : in STD_LOGIC;
			        c1 : in STD_LOGIC;
			        c2 : in STD_LOGIC;
			        c3 : in STD_LOGIC;
                    c4 : in STD_LOGIC;
			        c5 : in STD_LOGIC;
			        c6 : in STD_LOGIC;
			        c7 : in STD_LOGIC;
                    c8 : in STD_LOGIC;
			        c9 : in STD_LOGIC;
			        c10 : in STD_LOGIC;
			        c11 : in STD_LOGIC;
                    c12 : in STD_LOGIC;
			        c13 : in STD_LOGIC;
			        c14 : in STD_LOGIC;
			        c15 : in STD_LOGIC;
			        s0 : in STD_LOGIC;
			        s1 : in STD_LOGIC;
			        s2 : in STD_LOGIC;
			        s3 : in STD_LOGIC;
			        y0 : out STD_LOGIC
            );
             
        end component; 

    signal input 	: STD_LOGIC_VECTOR (0 to 15) 	:= (others => '0');
	signal control 	: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal output 	: STD_LOGIC 					:= '0';

    begin

		uut: mux_16_1 
			Port map(	c0 => input(0),
						c1 => input(1),
						c2 => input(2),
						c3 => input(3),
                        c4 => input(4),
						c5 => input(5),
						c6 => input(6),
						c7 => input(7),
                        c8 => input(8),
						c9 => input(9),
						c10 => input(10),
						c11 => input(11),
                        c12 => input(12),
						c13 => input(13),
						c14 => input(14),
						c15 => input(15),
						s0 => control(0),
						s1 => control(1),
                        s2 => control(2),
						s3 => control(3),
						y0 => output
					);

		stim_proc: process
		begin

        wait for 100 ns;

        input 	<= "1010101010101010";
		
		control <= "0000"; 
		wait for 10 ns; 
		
        control <= "0001"; 
		wait for 10 ns; 

        control <= "0010"; 
		wait for 10 ns; 

        control <= "0011"; 
		wait for 10 ns; 
			
        control <= "0100"; 
		wait for 10 ns;

        control <= "0101";
		wait for 10 ns; 

        control <= "0110";
		wait for 10 ns; 

        control <= "0111";
		wait for 10 ns; 

        control <= "1000"; 
		wait for 10 ns;
		
        control <= "1001"; 
		wait for 10 ns; 

        control <= "1010";
		wait for 10 ns; 

        control <= "1011"; 
		wait for 10 ns; 
			
		control <= "1100";
		wait for 10 ns; 
        
		control <= "1101";
		wait for 10 ns; 

        control <= "1110";
		wait for 10 ns; 

		control <= "1111";
		wait for 10 ns; 
		
		assert output = '0'
		report "errore"
		severity failure;

        wait;
		end process;
end; 