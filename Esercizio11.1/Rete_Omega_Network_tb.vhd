library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Rete_Omega_Network_tb is
end Rete_Omega_Network_tb;

architecture Behavioral of Rete_Omega_Network_tb is
component Rete_Omega_Network
    Port (ir0: in std_logic_vector(1 downto 0);
          ir1: in std_logic_vector(1 downto 0);
          ir2: in std_logic_vector(1 downto 0);
          ir3: in std_logic_vector(1 downto 0);
--          as: in std_logic_vector(1 downto 0);   --indirizzo selezione sorgente
          ad: in std_logic_vector(1 downto 0);   --indirizzo selezione destinatario
          or0: out std_logic_vector(1 downto 0);
          or1: out std_logic_vector(1 downto 0);
          or2: out std_logic_vector(1 downto 0);
          or3: out std_logic_vector(1 downto 0)
        );
        
end component;
signal ingresso0 : std_logic_vector (1 downto 0) := (others => '0');
signal ingresso1 : std_logic_vector (1 downto 0) := (others => '0');
signal ingresso2 : std_logic_vector (1 downto 0) := (others => '0');
signal ingresso3 : std_logic_vector (1 downto 0) := (others => '0');
--signal sel_source:  std_logic_vector(1 downto 0):=(others => '0');
signal sel_dest:  std_logic_vector(1 downto 0):=(others => '0');
signal uscita0 : std_logic_vector (1 downto 0) := (others => '0');
signal uscita1 : std_logic_vector (1 downto 0) := (others => '0');
signal uscita2 : std_logic_vector (1 downto 0) := (others => '0');
signal uscita3 : std_logic_vector (1 downto 0) := (others => '0');

begin
utt : Rete_Omega_Network
    port map(
             ir0 => ingresso0,
             ir1 => ingresso1,
             ir2 => ingresso2,
             ir3 => ingresso3,
--             as => sel_source,
             ad => sel_dest,
             or0 => uscita0,
             or1 => uscita1,
             or2 => uscita2,
             or3 =>uscita3
             );
             
    	stim_proc: process
		begin

        wait for 100 ns;
        
        ingresso0 <= "10";
        ingresso1 <= "01";
        ingresso2 <= "10";
        ingresso3 <= "11";
        
        
        sel_dest <= "01";
        wait for 100 ns;
        
        ingresso0 <= "00";
        ingresso1 <= "01";
        ingresso2 <= "10";
        ingresso3 <= "11";
 

        sel_dest <= "11";
        wait for 100 ns;
        
        
         ingresso0 <= "00";
        ingresso1 <= "00";
        ingresso2 <= "10";
        ingresso3 <= "11";


        sel_dest <= "10";
        wait for 100 ns;
        
        ingresso0 <= "00";
        ingresso1 <= "00";
        ingresso2 <= "00";
        ingresso3 <= "11";


        sel_dest <= "00";
        wait for 100 ns;
        
        ingresso0 <= "11";
        ingresso1 <= "00";
        ingresso2 <= "00";
        ingresso3 <= "11";
        

        sel_dest <= "10";

        wait;
		end process;
end; 
