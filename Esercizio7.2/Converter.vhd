library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Converter is
    Port (
          P: in std_logic_vector(15 downto 0);
          uscita: out std_logic_vector(31 downto 0)
         );
end Converter;

architecture Behavioral of Converter is
    constant BASE : integer := 10;
    signal temp_number : integer := 0;
    signal temp_abs_number : integer := 0;
    signal temp_abs_number1 : integer := 0;
    signal temp_abs_number2 : integer := 0;
    signal temp_abs_number3 : integer := 0;
    signal temp_abs_number4 : integer := 0;
    signal input_number : integer range -16384 to 16384;
    signal sign_bit :  std_logic_vector(3 downto 0);
    signal digit_4:  integer range 0 to 9;
    signal digit_3 :  integer range 0 to 9;
    signal digit_2 :  integer range 0 to 9;
    signal digit_1 :  integer range 0 to 9;
    signal digit_0 :  integer range 0 to 9;
    signal t_0: std_logic_vector(3 downto 0);
    signal t_1: std_logic_vector(3 downto 0);
    signal t_2: std_logic_vector(3 downto 0);
    signal t_3: std_logic_vector(3 downto 0);
    signal t_4: std_logic_vector(3 downto 0);
begin
    process(P)
    begin
        
        input_number <= to_integer(signed(P));
        temp_number <= input_number;
        
        if temp_number < 0 then
            sign_bit <= "1111";
            temp_abs_number  <= -temp_number;
            temp_abs_number1 <= -temp_number; 
            temp_abs_number2 <= -temp_number; 
            temp_abs_number3 <= -temp_number; 
            temp_abs_number4 <= -temp_number;             
        else
            sign_bit <= "1110";
            temp_abs_number  <= temp_number;
            temp_abs_number1 <= temp_number; 
            temp_abs_number2 <= temp_number; 
            temp_abs_number3 <= temp_number; 
            temp_abs_number4 <= temp_number; 
        end if;
        
           
        
        digit_4 <= temp_abs_number4 / 10000;
        
        digit_3 <= (temp_abs_number3 / 1000) mod 10;
        
        digit_2 <= (temp_abs_number2 / 100) mod 10;
        
        digit_1 <= (temp_abs_number1  / 10) mod 10;

        digit_0 <= temp_abs_number mod 10;
        
        t_0 <= std_logic_vector(to_signed(digit_0,t_0'length));
        t_1 <= std_logic_vector(to_signed(digit_1,t_1'length));
        t_2 <= std_logic_vector(to_signed(digit_2,t_2'length));
        t_3 <= std_logic_vector(to_signed(digit_3,t_3'length));
        t_4 <= std_logic_vector(to_signed(digit_4,t_4'length));
        
        uscita <= "00000000" & sign_bit & t_4 & t_3 & t_2 & t_1 & t_0;
    end process;


end Behavioral;
