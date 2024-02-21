library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port (
          enable_data1 : in std_logic; -- posso inserire il primo blocco di dati
          enable_data2: in std_logic; -- posso inserire il secondo blocco di dati
          enable_sel: in std_logic;  -- posso inserire le selezioni
          input_data1: in std_logic_vector(0 to 7);
          input_data2: in std_logic_vector(0 to 7);
          input_sel: in std_logic_vector(0 to 5);
          value_data: out std_logic_vector(0 to 15);
          value_sel: out std_logic_vector(0 to 5)
         );
end Control;

architecture Behavioral of Control is
    signal data : std_logic_vector(0 to 15);
    signal sel: std_logic_vector(0 to 5);
begin
    value_data <= data;
    value_sel <= sel;
    main: process
        begin 
            if(enable_data1 = '1') then
                data(0 to 7) <= input_data1(0 to 7);
                if(enable_data2 = '1') then
                    data(8 to 15) <= input_data2(0 to 7);
                end if;
             end if;
             if(enable_sel = '1') then 
                sel(0 to 5) <= input_sel(0 to 5);
             end if;
        end process;

end Behavioral;
