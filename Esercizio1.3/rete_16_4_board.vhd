----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 14:44:54
-- Design Name: 
-- Module Name: rete_16_4_board - Structural
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

entity rete_16_4_board is
    Port (
          load_data1: in std_logic;
          load_data2: in std_logic;
          load_sel: in std_logic;
          switches: in std_logic_vector(0 to 7);
          sel_switches: in std_logic_vector(0 to 5);
          led: out std_logic_vector(0 to 3)
          );
end rete_16_4_board;

architecture Structural of rete_16_4_board is
    component rete16_4
        Port (
            i : in std_logic_vector(0 to 15);
            sel1 : in std_logic_vector(0 to 3);
            sel2 : in std_logic_vector(0 to 1);
            o : out std_logic_vector(0 to 3)
           );
    end component;
    
    component Control
        Port (
          enable_data1 : in std_logic; 
          enable_data2: in std_logic; 
          enable_sel: in std_logic;  
          input_data1: in std_logic_vector(0 to 7);
          input_data2: in std_logic_vector(0 to 7);
          input_sel: in std_logic_vector(0 to 5);
          value_data: out std_logic_vector(0 to 15);
          value_sel: out std_logic_vector(0 to 5)
         );
    end component;
    
    signal input: std_logic_vector(0 to 15);
    signal selezione: std_logic_vector(0 to 5);
begin
                 
     uut1: Control
        port map(
                 load_data1,
                 load_data2,
                 load_sel,
                 switches,
                 switches,
                 sel_switches,
                 input,
                 selezione
                 );
                 
       uut2: rete16_4
        port map(
                  input,
                  selezione(0 to 3),
                  selezione(4 to 5),
                  led
                 );
                 


end Structural;
