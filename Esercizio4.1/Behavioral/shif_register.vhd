

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic ( N: integer := 4);
    port(CLK, RST : in std_logic;
         EO, EI: in std_logic;  --EI ingresso seriale da sinistra EO ingresso seriale da destra
         SO  : out std_logic;
         s : in std_logic;      -- segnale di abilitazione per shfit sinistra o destra
         Y: in std_logic);
end shift_register;

architecture Behavioral of shift_register is
    signal tmp: std_logic_vector(N-1 downto 0);
begin
    
    process (CLK)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            elsif(Y = '0') then -- shift di una poszione
                if(s = '0') then -- shift a sinistra
                    tmp(N-1) <= EO;
                    tmp(N-2 downto 0) <= tmp(N-1 downto 1);
                else      -- shift a destra 
                    tmp(0) <= EI;
                    tmp(N-1 downto 1) <= tmp(N-2 downto 0);
                end if;
             else                   --shift di due posizioni
                if(s = '0') then   -- shift a sinistra
                    tmp(N-1) <= '0';
                    tmp(N-2) <= EO;
                    for i in N-3 downto 0 loop
                        tmp(i) <= tmp(i+2);
                    end loop;
                else    -- shift a destra
                    tmp(0) <= '0';
                    tmp(1) <= EI;
                    for i in N-3 downto 0 loop
                        tmp(i+2) <= tmp(i);
                    end loop;
                end if;
            end if;
            if(s = '0') then
                SO <= tmp(0);
            else
                SO <= tmp(N-1);
            end if;
        end if;

      end process;
      
--      SO <= tmp(N-1) when s='1' else
--            tmp(0);  
        
end Behavioral;

				
				
