library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;
use STD.TEXTIO.ALL;

entity Debayering_Filter_tb is
end Debayering_Filter_tb;

architecture test_bench of Debayering_Filter_tb is
 constant N_tb : integer := 32;

 component Debayering_Filter
 Port (
  clk : IN STD_LOGIC;
  rst : IN STD_LOGIC;
  pixel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  valid_in,new_image : IN STD_LOGIC; --signals when it is valid to start the multiplication process
  R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  G : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
  --outputs :out STD_LOGIC_VECTOR(31 DOWNTO 0):=  (others => '0');
  valid_out: OUT STD_LOGIC;
  image_finished: OUT STD_LOGIC;
  out_row_all , out_col_all : OUT  std_logic_vector(integer(ceil(log2(real( N_tb))))-1 downto 0)  :=  (others => '0')
  );
 end component;

 -- Input Signals
 signal clk : std_logic := '0';
 signal rst: std_logic := '0';
 signal valid_in : std_logic := '1';
 signal new_image: std_logic := '0';
 signal pixel : STD_LOGIC_VECTOR(7 DOWNTO 0);
 -- Output Signals
 signal R : STD_LOGIC_VECTOR(7 DOWNTO 0);
 signal G : STD_LOGIC_VECTOR(7 DOWNTO 0);
 signal B : STD_LOGIC_VECTOR(7 DOWNTO 0);
 signal image_finished: STD_LOGIC;
 signal valid_out : std_logic := '0';
 signal out_col_signal, out_row_signal: std_logic_vector(integer(ceil(log2(real(N_tb))))-1 downto 0);
 -- Clock
 constant CLK_PERIOD : time := 10ns;

 -- File I/O
 file input_file : text open read_mode is "C:\Users\panag\Desktop\input.txt";
 file output_file : text open write_mode is "C:\Users\panag\Desktop\output.txt";

begin 
 wrapper_instance: Debayering_Filter
 port map(
  clk => clk,
  rst => rst,
  pixel => pixel,
  valid_in => valid_in,
  new_image => new_image,
  R => R,
  B => B,
  G => G,
  image_finished => image_finished,
  valid_out => valid_out,
   out_row_all  =>out_row_signal ,
   out_col_all =>out_col_signal
   
 );

 clk_proc: process
 begin
  clk <= '0';
  wait for CLK_PERIOD / 2;
  clk <= '1';
  wait for CLK_PERIOD / 2;
 end process;

 CHANGE_RST_validin: process
 begin
  rst <= '0';
  valid_in <= '1';
  wait for N_tb * N_tb * CLK_PERIOD;
 end process;

 CHANGE_new_image: process
 begin
  new_image <= '1';
  wait for CLK_PERIOD;
  new_image <= '0';
  wait for ((2*N_tb +3+ (N_tb * N_tb ))* CLK_PERIOD) - CLK_PERIOD;
 end process;

 -- Read pixel values from input file
 READ_PIXELS: process
  variable input_line : line;
  variable input_pixel : integer;
  variable end_of_file : boolean := false;
 begin
  while not end_of_file loop
   if endfile(input_file) then
    end_of_file := true;
   else
    readline(input_file, input_line);
    read(input_line, input_pixel);
    pixel <= std_logic_vector(to_unsigned(input_pixel, 8));
    wait for CLK_PERIOD;
   end if;
  end loop;
  wait;
 end process;

 -- Write RGB values to output file
 WRITE_OUTPUTS: process
  variable output_line : line;
 begin
  while true loop
   wait until clk'event and clk = '1';
   if valid_out = '1' then
    write(output_line, integer'image(to_integer(unsigned(R))));
    write(output_line, string'(" "));
    write(output_line, integer'image(to_integer(unsigned(G))));
    write(output_line, string'(" "));
    write(output_line, integer'image(to_integer(unsigned(B))));
    writeline(output_file, output_line);
   end if;
  end loop;
 end process;

end test_bench;
