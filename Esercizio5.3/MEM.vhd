library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.math_real.all;
-- riceve il dato dalla Macchina M e lo scrive in memoria
-- il write 
entity MEM is
    generic(
            N: integer := 8
          );
    Port (
          CLK : in std_logic;
          RESET: in std_logic;
          input : in std_logic_vector(31 downto 0);
          address: in std_logic_vector( integer(log2(real(N)))-1 downto 0);
          write : in std_logic;
          loc: out std_logic_vector(31 downto 0);
          bot_v: in std_logic
         );
end MEM;

architecture Behavioral of MEM is
    type MEM_N_32 is array (0 to N-1) of std_logic_vector(31 downto 0);
    signal memory: MEM_N_32;
    signal i: integer:=1;
begin
    main: process(CLK)
        begin
            if(CLK'event and CLK='1') then 
                if(RESET = '1') then 
                    memory(0 to N-1) <= (others => "00000000000000000000000000000000");
                elsif(write = '1') then 
                    memory(to_integer(unsigned(address))) <= input;
                end if;
             end if;
        end process;  
        
        visual: process(CLK)
        begin 
            if(CLK'event and CLK='1') then
                if(bot_v = '1') then 
                    loc <= memory(i);
                    i <= i+1;
                end if; 
                if( i = N-1 or RESET = '1') then 
                    i <= 1;
                end if;
             end if;
         end process;
                    

end Behavioral;

