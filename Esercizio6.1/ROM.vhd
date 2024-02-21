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
        "00000000",--0		                            
        "00000010",--1
        "00001010",--3
        "00000010",--1
        "00001000",--2
        "00000101",--0
        "00000110",--1
        "00000111",--1
        "00001000",--2
        "00001001",--2
        "00001010",--3
        "00001011",--3
        "00001100",--2
        "00001101",--2
        "00001110",--3
        "00101111"--7
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
