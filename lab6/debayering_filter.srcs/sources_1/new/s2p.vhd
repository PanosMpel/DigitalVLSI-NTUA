library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity ramruns is
    generic ( N: integer := 32 );
    port (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        col,row : OUT std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)  :=  (others => '0') ;
         s00 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s01 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s02 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s10 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s11 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s12 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s20 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s21 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        s22 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
         image_finished: OUT STD_LOGIC := '0' ;
        valid_out: OUT STD_LOGIC; 
        
        out_row , out_col : OUT  std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)  :=  (others => '0')  
       
    );
end ramruns;

architecture Behavioral of ramruns is

  
  COMPONENT fifo_generator_0 
  Port ( 
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );
END COMPONENT;

component dff is
    port(
      d : in  std_logic_vector(7 downto 0);
      q : out  std_logic_vector(7 downto 0);
      clk : in std_logic;
      rst : in std_logic
     );
end component;


signal ram_out_2, ram_out_1, ram_out_0 : std_logic_vector(7 downto 0) :=  (others => '0') ;
signal  rd_en0: std_logic := '0';
signal  rd_en1: std_logic := '0';
signal  rd_en2: std_logic := '0';
signal  wr_en0: std_logic := '0';
signal  wr_en1: std_logic := '0';
signal  wr_en2: std_logic := '0';
signal t1,t2,t3,t4,t5,t6,t7,t8,t9 : STD_LOGIC_VECTOR(7 DOWNTO 0)  :=  (others => '0');

signal full0, full1, full2, empty0, empty1, empty2: std_logic;
signal pixel_delay1 ,pixel_delay2  : STD_LOGIC_VECTOR(7 DOWNTO 0)  :=  (others => '0');
signal col_temp,row_temp :  std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) :=  (others => '0');
signal  col_signal : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)  :=  (others => '0') ;

 
signal counter_begin :  std_logic_vector(integer(ceil(log2(real(N*N)))) downto 0) :=  (others => '0') ;
 
begin

dffdelay1 : dff port map(d=>pixel, clk=>clk, rst=>rst, q=>pixel_delay1 );
dffdelay2 : dff port map(d=>pixel_delay1, clk=>clk, rst=>rst, q=>pixel_delay2 );
 
 
RAM_FIFO_0 : fifo_generator_0
    PORT MAP (
        clk => clk,
        srst => rst,
        din => pixel_delay2,
        wr_en => wr_en0,
        rd_en => rd_en0,
        dout => ram_out_0,
        full => full0,
        empty => empty0
    );

RAM_FIFO_1 : fifo_generator_0
PORT MAP (
    clk => clk,
    srst => rst,
    din => ram_out_0,
    wr_en => wr_en1,
    rd_en => rd_en1,
    dout => ram_out_1,
    full => full1,
    empty => empty1
);

RAM_FIFO_2 : fifo_generator_0
PORT MAP (
    clk => clk,
    srst => rst,
    din => ram_out_1,
    wr_en => wr_en2,
    rd_en => rd_en2,
    dout => ram_out_2,
    full => full2,
    empty => empty2
);
 
 dff00 : dff port map(d=>ram_out_0, clk=>clk, rst=>rst, q=>t1);
 s00 <=t1;
dff01 : dff port map(d=>t1, clk=>clk, rst=>rst, q=>t2);
 s01 <=t2;
dff02 : dff port map(d=>t2, clk=>clk, rst=>rst, q=>t3);
 s02 <=t3;
dff10 : dff port map(d=>ram_out_1, clk=>clk, rst=>rst, q=>t4);
 s10 <=t4;
dff11 : dff port map(d=>t4, clk=>clk, rst=>rst, q=>t5);
 s11 <=t5;
dff12 : dff port map(d=>t5, clk=>clk, rst=>rst, q=>t6);
 s12 <=t6;
dff20 : dff port map(d=>ram_out_2, clk=>clk, rst=>rst, q=>t7);
 s20 <=t7;
dff21 : dff port map(d=>t7,clk=>clk, rst=>rst, q=>t8);
 s21 <=t8;
dff22 : dff port map(d=>t8, clk=>clk, rst=>rst, q=>t9);
 s22 <=t9;
 


 process(clk,rst) 
 --constant N : integer :=32;
 begin 
  
   if( rst = '1') then 
        
                  wr_en0 <= '0';
                  rd_en0 <= '0';
                  wr_en1 <= '0';
                  rd_en1 <= '0';
                  wr_en2 <= '0';
                  rd_en2 <= '0';
                  counter_begin <=(others => '0');
                  row<= (others => '0');
                  col <=  (others => '0');
                  
                 
     --RESET  
    elsif rising_edge(clk) then
           valid_out <='0'; 
           image_finished <='0';
         
       
       if (valid_in = '1' AND new_image ='1' ) then 
       
           counter_begin <= (others => '0'); 
           row_temp<= (others => '0') ; 
           col_temp <= (others => '0') ; 
           image_finished <='0';
           
           
      else if( valid_in = '1' ) then 

          wr_en0 <= '1';
          counter_begin <= counter_begin + 1 ;
            
           if (to_integer(unsigned(counter_begin)) >= N-2) then   
                   rd_en0 <= '1';                  
                   wr_en1 <='1';
           end if;        
           if(to_integer(unsigned(counter_begin)) >=  2*N-3) then      
                   rd_en1 <='1';
           end if;        
           if(to_integer(unsigned(counter_begin)) >=  2*N-2) then 
                   wr_en2 <='1';
           end if; 
           if(to_integer(unsigned(counter_begin)) >= 3*N-3) then 
                      rd_en2 <='1';
           end if;
         


    if( counter_begin > 2*N +1) then  
             
             valid_out <='1';                   
             col_signal <=col_temp;
             
             if(row_temp = 0 and col_temp = 0) then
                col <=  col_temp + 1 ;
             else
                col <=  col_temp+1;
             end if;
                
             row <=  row_temp;
             out_row <= row_temp;
             out_col <= col_temp;
             col_temp <= col_temp+1;
              
             if (to_integer(unsigned(col_signal)) = N-2) then   --allazw grammh
                   row_temp <= row_temp + 1 ;
                   col_temp <= (others => '0') ;
             end if;                          
             if (to_integer(unsigned(row_temp))= N-1 and to_integer(unsigned(col_temp)) = N-1) then 
                    image_finished <= '1';
             end if;      

        end if;
        end if;
    end if;     
  end if;
  
  end process;
end Behavioral;
