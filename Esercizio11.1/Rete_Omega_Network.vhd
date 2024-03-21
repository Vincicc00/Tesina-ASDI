library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Rete_Omega_Network is
Port (
      ir0: in std_logic_vector(1 downto 0);  -- primo ingresso switch alto sx
      ir1: in std_logic_vector(1 downto 0);  -- primo ingresso switch basso sx
      ir2: in std_logic_vector(1 downto 0);  -- secondo ingresso switch alto sx
      ir3: in std_logic_vector(1 downto 0);  -- secondo ingresso switch basso sx
      ad: in std_logic_vector(1 downto 0);   --indirizzo di selezione destinatario
      or0: out std_logic_vector(1 downto 0); -- prima uscta alto dx
      or1: out std_logic_vector(1 downto 0); -- seconda uscta alto dx
      or2: out std_logic_vector(1 downto 0); -- prima uscta basso dx
      or3: out std_logic_vector(1 downto 0)  -- seconda uscta basso dx
     );
end Rete_Omega_Network;

architecture Structural of Rete_Omega_Network is
component switch
        Port (
              is0 :in std_logic_vector (1 downto 0);
              is1 :in std_logic_vector (1 downto 0);
              s0: in std_logic;
              s1: in std_logic;
              os0 :out std_logic_vector (1 downto 0);
              os1 :out std_logic_vector (1 downto 0)
            );
end component;

component Arbitro 
    Port (
          ing0: in std_logic_vector(1 downto 0);  -- primo ingresso switch alto sx
          ing1: in std_logic_vector(1 downto 0);  -- primo ingresso switch basso sx
          ing2: in std_logic_vector(1 downto 0);  -- secondo ingresso switch alto sx
          ing3: in std_logic_vector(1 downto 0);  -- secondo ingresso switch basso sx
          as: out std_logic_vector(1 downto 0);   --indirizzo di selezione sorgente
          usc0: out std_logic_vector(1 downto 0); -- prima uscta alto dx
          usc1: out std_logic_vector(1 downto 0); -- seconda uscta alto dx
          usc2: out std_logic_vector(1 downto 0); -- prima uscta basso dx
          usc3: out std_logic_vector(1 downto 0)  -- seconda uscta basso dx 
         );
end component;

signal Usc_Ar0 : std_logic_vector(1 downto 0) := (others => '0');
signal Usc_Ar1 : std_logic_vector(1 downto 0) := (others => '0');
signal Usc_Ar2 : std_logic_vector(1 downto 0) := (others => '0');
signal Usc_Ar3 : std_logic_vector(1 downto 0) := (others => '0');
signal u0 : std_logic_vector (1 downto 0) := (others => '0');
signal u1 : std_logic_vector (1 downto 0) := (others => '0');
signal u2 : std_logic_vector (1 downto 0) := (others => '0');
signal u3 : std_logic_vector (1 downto 0) := (others => '0');
signal s_source: std_logic_vector(1 downto 0) := (others => '0');
begin

ref: Arbitro
    Port map(
              ing0 => ir0,
              ing1 => ir1,
              ing2 => ir2,
              ing3 => ir3,
              as => s_source,
              usc0 => Usc_Ar0,
              usc1 => Usc_Ar1,
              usc2 => Usc_Ar2,
              usc3 => Usc_Ar3
            );

switch1 : switch --alto a sx
    port map(
             is0 =>Usc_Ar0,
             is1 =>Usc_Ar2,
             s0 => s_source(1),
             s1 => ad(1),
             os0 =>u0,
             os1 =>u1    
    );
switch2 : switch --basso a sx
    port map(
             is0 =>Usc_Ar1,
             is1 =>Usc_Ar3,
             s0 => s_source(1),
             s1 => ad(1),
             os0 =>u2,
             os1 =>u3    
           );
           
switch3 : switch --alto a dx
    port map(
             is0 =>u0,
             is1 =>u2,
             s0 => s_source(0),
             s1 => ad(0),
             os0 =>or0,
             os1 =>or1    
           );
           
switch4 : switch -- basso a dx
    port map(
             is0 =>u1,
             is1 =>u3,
             s0 => s_source(0),
             s1 => ad(0),
             os0 =>or2,
             os1 =>or3    
            );
end Structural;
