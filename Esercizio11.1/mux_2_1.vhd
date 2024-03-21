----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2024 17:24:02
-- Design Name: 
-- Module Name: mux_2_1 - Dataflow
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

entity mux_2_1 is
 Port ( i0: in std_logic_vector (1 downto 0);
        i1: in std_logic_vector (1 downto 0);
        s: in std_logic;
        y: out std_logic_vector (1 downto 0)
    );
end mux_2_1;

architecture Behavioral of mux_2_1 is
begin
    process(s, i0, i1)
    begin
        if s = '0' then 
            y <= i0;
        else
            y <= i1;
        end if;
    end process;
end Behavioral;