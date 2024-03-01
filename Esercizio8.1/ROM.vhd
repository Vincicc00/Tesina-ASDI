library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- riceve un address dal cont solo se lo start è alto 
-- e invia alla Macchina M
entity ROM is
    port(
        CLK : in std_logic;
        RST: in std_logic;
        address : in  std_logic_vector(3 downto 0);
        dout    : out std_logic_vector(7 downto 0);
        read : in std_logic
    );
end entity ROM;

architecture Behavioral of ROM is
    type MEMORY_16_8 is array (0 to 15) of std_logic_vector(7 downto 0);      
    constant ROM_16_8 : MEMORY_16_8 :=( 	      
        "00000000",		                            
        "00000001",
        "00000010",
        "00000011",
        "00000100",
        "00000101",
        "00000110",
        "00000111",
        "00001000",
        "00001001",
        "00001010",
        "00001011",
        "00001100",
        "00001101",
        "00001110",
        "00001111"
    );
begin
    
    main : process(CLK)
    begin
        if(ClK'event and CLK = '1') then 
            if(RST = '1') then 
                dout <= (others=>'0');
            elsif (read ='1') then 
               dout <= ROM_16_8(to_integer(unsigned(address)));
            end if;
        end if;
    end process;


end Behavioral;
