library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_B is
    Generic(
            M: integer := 7;
            N: integer := 3
           );
    Port (
          clock: in std_logic;
          reset: in std_logic;
          ACK: out std_logic;
          dato: in std_logic_vector(M downto 0);
          strobe : in std_logic;
          usc: inout std_logic_vector(M+1 downto 0)
          );
end Sistema_B;

architecture Structural of Sistema_B is
    component CU_B
        Port(
          clock: in std_logic;
          reset: in std_logic;
          strobe: in std_logic;
          enable_count: out std_logic;
          ACK: out std_logic;
          write: out std_logic;
          read: out std_logic;
          load_reg: out std_logic
          );
        end component;  
       
     component ROM
        Port(
            CLK: in std_logic;
            RST: in std_logic;
            address: in std_logic_vector(3 downto 0);
            dout: out std_logic_vector(7 downto 0);
            read: in std_logic
            );
        end component;
       
     component counter
        generic( 
                N: integer := 3
                );
        Port(
            CLK: in std_logic;
            RESET: in std_logic;
            enable: in std_logic;
            y: out std_logic_vector(N downto 0)
            );
     end component;
        
     component ripple_carry
        port( 
             X, Y: in std_logic_vector(7 downto 0);
		     c_in: in std_logic;
		     c_out: out std_logic;
		     Z: out std_logic_vector(7 downto 0)
		    );
     end component;
     
     component MEM
        generic( 
                M: integer :=7;
                N: integer := 3
               );
        Port (
              CLK : in std_logic;
              RST: in std_logic;
              input : in std_logic_vector(M+1 downto 0);
              address: in std_logic_vector(N downto 0);
              write : in std_logic
             );  
     end component; 
     
     component registro8
        generic(
                M: integer :=7
             );
        port( 
             A: in std_logic_vector(M downto 0);
		     clk, res, load: in std_logic;
		     B: out std_logic_vector(M downto 0)
		    );
     end component; 
     
     signal t_enable_count: std_logic;
     signal t_ACK: std_logic;
     signal t_write: std_logic;
     signal t_load_reg: std_logic;
     signal t_address: std_logic_vector(3 downto 0);
     signal op1, op2: std_logic_vector(7 downto 0);
     signal t_read: std_logic;
     signal t_out: std_logic_vector(7 downto 0);
     signal t_cout: std_logic;
begin

    CU: CU_B
        port map(
                 clock => clock,
                 reset => reset,
                 strobe => strobe,
                 enable_count => t_enable_count,
                 ACK => t_ACK,
                 write => t_write,
                 read => t_read,
                 load_reg => t_load_reg
                );
    
    rom_y: ROM
        port map(
                 CLK => clock,
                 RST => reset,
                 address => t_address,
                 dout => op1,
                 read => t_read
                );
                
    cont: counter
        generic map(
                     3
                    )
        port map(
                 CLK => clock,
                 RESET => reset,
                 enable => t_enable_count,
                 y => t_address
                );  
                
    adder: ripple_carry
        port map(
                 X => op1,
                 Y => op2,
                 c_in => '0',
                 c_out => t_cout,
                 Z => t_out 
                );
    
    usc <= t_cout & t_out;
    
    memor: MEM
        generic map(
                    7,
                    3
                   )
        port map(
                 CLK => clock,
                 RST => reset,
                 input => usc,
                 address => t_address,
                 write => t_write
                );
     
    reg: registro8
        generic map(
                    7
                   )
        port map(
                 A => dato, 
                 clk => clock,
                 res => reset,
                 load => t_load_reg,
                 B => op2
                );
                
       ACK <= t_ACK;
end Structural;