library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity M is
    port(
        input   : in  std_logic_vector(7 downto 0);
        output  : out std_logic_vector(3 downto 0)
    );
end entity M;

architecture r of M is

begin  
    
    main : process(input)
    begin

    
    output <= input(7) & input(5) & input(3) & input(1);    

    end process main;

end architecture r;
