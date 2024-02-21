library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
-- riceve il dato dalla Macchina M e lo scrive in memoria
-- il write 
entity MEM is
    Port (
          CLK : in std_logic;
          RST: in std_logic;
          input : in std_logic_vector(3 downto 0);
          address: in std_logic_vector(3 downto 0);
          write : in std_logic
         );
end MEM;

architecture Behavioral of MEM is
    type MEM_16_8 is array (0 to 15) of std_logic_vector(3 downto 0);
    signal memory: MEM_16_8;
begin
    main: process(CLK)
        begin
            if(CLK'event and CLK='1') then 
                if(RST = '1') then 
                    memory(0 to 15) <= (others => "0000");
                elsif(write = '1') then 
                    memory(to_integer(unsigned(address))) <= input;
                end if;
             end if;
        end process; 
        

end Behavioral;

