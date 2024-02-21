----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2024 15:29:36
-- Design Name: 
-- Module Name: FF_D - Behavioral
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

entity FF_D is
    Port (  
            CLK : in std_logic;
            RST : in std_logic;
            d : in std_logic;
            q : out std_logic 
          );
end FF_D;

architecture Behavioral of FF_D is
    signal temp : std_logic := '0'; 
begin
        q <= temp;
        ff: process (CLK)
            begin 
                if(CLK'event and CLK = '1') then 
                    if(RST = '1') then 
                        temp <= '0';
                    else
                        temp <= d;
                    end if;
                 end if;
            end process;
end Behavioral;
