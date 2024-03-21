----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2024 17:24:02
-- Design Name: 
-- Module Name: demux_1_2 - Dataflow
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux_1_2 is
    Port (i: in std_logic_vector(1 downto 0);
        s: in std_logic;
        y0: out std_logic_vector(1 downto 0);
        y1: out std_logic_vector(1 downto 0)
     );
end demux_1_2;

architecture Behavioral of demux_1_2 is

begin
 process(s,i)
    begin
        if s = '0' then 
            y0<= i;
            y1<= "00";
        else
            y1 <= i;
            y0<= "00";
        end if;
    end process;

end  Behavioral;
