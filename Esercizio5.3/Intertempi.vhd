
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

entity Intertempi is
    generic(
            n: integer := 4
           );
    Port (
          CLK: in std_logic;
          RST: in std_logic;
          bot: in std_logic;
          value: in std_logic_vector(31 downto 0);
          bot_v: in std_logic;
          loc: out std_logic_vector(31 downto 0)
         );
end Intertempi;

architecture Structural of Intertempi is
    component Counter
        generic(
                m : integer := 8;  -- questo ci dice fino a che conta il counter
                n: integer := 3   -- questo ci da la lunghezza del vector, il numero di bit
               );
        Port (
              CLK : in std_logic;
              RESET: in std_logic;
              enable: in std_logic;
              load: in std_logic;
              data: in std_logic_vector(n-1 downto 0);
              y: out std_logic_vector(n-1 downto 0); -- uscita contatore
              count: out std_logic   -- ci serve per abilitare il contatore successivo
             );
    end component; 
    
    component MEM
        generic(
                N: integer := 8
              );
        Port (
              CLK: in std_logic;
              RESET: in std_logic;
              input : in std_logic_vector(31 downto 0);
              address: in std_logic_vector(integer(log2(real(N)))-1 downto 0);
              write : in std_logic;
              loc: out std_logic_vector(31 downto 0);
              bot_v: in std_logic
             );
    end component;
    
    signal temp: std_logic;
    signal tempg: std_logic_vector(n-1 downto 0);
    signal addr: std_logic_vector(n-1 downto 0);
    signal non: std_logic;
    signal i: std_logic_vector(n-1 downto 0);
begin
     
     cont: Counter
        generic map(
                    16,
                    4
                   )
        port map(
                 CLK => CLK,
                 RESET => RST, 
                 enable => bot,
                 load => temp,
                 data => tempg, 
                 y => addr,
                 count => non
                );               
        memoria: MEM
            generic map(
                        16
                       )
            port map(
                     CLK => CLK,
                     RESET => RST,
                     input => value,
                     address => addr,
                     write => bot,
                     loc => loc,
                     bot_v => bot_v
                    );
                    

end Structural;
