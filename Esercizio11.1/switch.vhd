
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
    Port(
          is0 :in std_logic_vector (1 downto 0);
          is1 :in std_logic_vector (1 downto 0);
          s0: in std_logic;
          s1: in std_logic;
          os0 :out std_logic_vector (1 downto 0);
          os1 :out std_logic_vector (1 downto 0)
     );
end switch;

architecture Structural of switch is
component mux_2_1 
     Port ( 
            i0: in std_logic_vector (1 downto 0);
            i1: in std_logic_vector (1 downto 0);
            s: in std_logic;
            y: out std_logic_vector (1 downto 0)
        );
end component;

component demux_1_2
        Port (
        i: in std_logic_vector(1 downto 0);
        s: in std_logic;
        y0: out std_logic_vector(1 downto 0);
        y1: out std_logic_vector(1 downto 0)
     );
end component;
signal u : std_logic_vector(1 downto 0) := (others => '0');

begin

mux: mux_2_1
    port map(
             i0 => is0,
             i1 => is1,
             s => s0,
             y => u
             );
             
demux: demux_1_2
    port map(
             i => u,
             s => s1,
             y0 => os0,
             y1 => os1
             );

end Structural;
