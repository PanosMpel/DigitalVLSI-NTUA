----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2024 08:48:40 PM
-- Design Name: 
-- Module Name: cell_4_parallel - structural
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

entity cell_4_parallel is
    Port ( B_cell4 : in STD_LOGIC;
           A_cell4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_cell4 : in STD_LOGIC;
           Sin_cell4 : in STD_LOGIC_VECTOR (3 downto 0);
           Sout_cell4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_cell4 : out STD_LOGIC;
           CLK : in STD_LOGIC;
           RSTn : in STD_LOGIC;
           A_cell4_out :out STD_LOGIC_VECTOR (3 downto 0)); 
          -- B_cell4_out: out STD_LOGIC);
end cell_4_parallel;

architecture structural of cell_4_parallel is

signal tmp_cout_cell : std_logic_vector(2 downto 0);
 signal tmp_B_cell4_out : std_logic_vector(3 downto 0);
component cell is 
   Port ( Aj : in STD_LOGIC;
           Bi : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sout : out STD_LOGIC;
           CLK : in STD_LOGIC;
           Aj_out:out STD_LOGIC;
           Bi_out:out STD_LOGIC;
           RSTn : in STD_LOGIC);
end component;

begin
--------------------------------------------------mpainei Sin=>Sin_cell4(0) se kathe cell4, mallon lathos?
cell_1 : cell port map(Aj=>A_cell4(0),Bi=>B_cell4,Cin=>Cin_cell4,Sin=>Sin_cell4(0),Cout=>tmp_cout_cell(0),Sout=>Sout_cell4(0),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(0),Bi_out=>tmp_B_cell4_out(0));
cell_2 : cell port map(Aj=>A_cell4(1),Bi=>tmp_B_cell4_out(0),Cin=>tmp_cout_cell(0),Sin=>Sin_cell4(1),Cout=>tmp_cout_cell(1),Sout=>Sout_cell4(1),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(1),Bi_out=>tmp_B_cell4_out(1));
cell_3 : cell port map(Aj=>A_cell4(2),Bi=>tmp_B_cell4_out(1),Cin=>tmp_cout_cell(1),Sin=>Sin_cell4(2),Cout=>tmp_cout_cell(2),Sout=>Sout_cell4(2),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(2),Bi_out=>tmp_B_cell4_out(2));
cell_4 : cell port map(Aj=>A_cell4(3),Bi=>tmp_B_cell4_out(2),Cin=>tmp_cout_cell(2),Sin=>Sin_cell4(3),Cout=>Cout_cell4,Sout=>Sout_cell4(3),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(3),Bi_out=>tmp_B_cell4_out(3));
 
end structural;
