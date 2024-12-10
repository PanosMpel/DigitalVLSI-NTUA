-- Company:
-- Engineer:
--
-- Create Date: 14.04.2024 00:08:24
-- Design Name:
-- Module Name: cell_First_4_parallel - structural
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

entity cell_First_4_parallel is
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
end cell_First_4_parallel;

architecture structural of cell_First_4_parallel is
signal A1_first_delay :STD_LOGIC;
signal A2_first_delay : std_logic_vector(1 downto 0);
signal A3_first_delay : std_logic_vector(2 downto 0);
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
component reg is
    Port ( D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RSTn : in STD_LOGIC;
           Q : out STD_LOGIC);
  end component;
begin
----------------------Delay for A1
reg_A1_1_first_delay: reg port map(D=>A_cell4(1) ,CLK=>CLK,RSTn=>RSTn,Q=>A1_first_delay);


--reg_A1_2_first_delay: reg port map(D=>A1_first_delay(0) ,CLK=>CLK,RSTn=>RSTn,Q=>A1_first_delay(1));
--reg_A1_3_first_delay: reg port map(D=>A1_first_delay(1) ,CLK=>CLK,RSTn=>RSTn,Q=>A1_first_delay(2));
 
----------------------Delay for A2
reg_A2_1_first_delay: reg port map(D=>A_cell4(2) ,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(0));
reg_A2_2_first_delay: reg port map(D=>A2_first_delay(0) ,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(1));
--reg_A2_3_first_delay: reg port map(D=>A2_first_delay(1) ,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(2));
--reg_A2_4_first_delay: reg port map(D=>A2_first_delay(2) ,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(3));

----------------------Delay for A3


reg_A3_1_first_delay: reg port map(D=>A_cell4(3) ,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(0));
reg_A3_2_first_delay: reg port map(D=>A3_first_delay(0) ,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(1));
reg_A3_3_first_delay: reg port map(D=>A3_first_delay(1) ,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(2));
-- reg_A3_4_first_delay: reg port map(D=>A3_first_delay(2) ,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(3));
 --  reg_A3_3_first_delay: reg port map(D=>A3_first_delay(1) ,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(2));
 
--------------------------------------------------mpainei Sin=>Sin_cell4(0) se kathe cell4, mallon lathos?
cell_1 : cell port map(Aj=>A_cell4(0),Bi=>B_cell4,Cin=>Cin_cell4,Sin=>Sin_cell4(0),Cout=>tmp_cout_cell(0),Sout=>Sout_cell4(0),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(0),Bi_out=>tmp_B_cell4_out(0));
cell_2 : cell port map(Aj=>A1_first_delay,Bi=>tmp_B_cell4_out(0),Cin=>tmp_cout_cell(0),Sin=>Sin_cell4(1),Cout=>tmp_cout_cell(1),Sout=>Sout_cell4(1),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(1),Bi_out=>tmp_B_cell4_out(1));
cell_3 : cell port map(Aj=>A2_first_delay(1),Bi=>tmp_B_cell4_out(1),Cin=>tmp_cout_cell(1),Sin=>Sin_cell4(2),Cout=>tmp_cout_cell(2),Sout=>Sout_cell4(2),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(2),Bi_out=>tmp_B_cell4_out(2));
cell_4 : cell port map(Aj=>A3_first_delay(2),Bi=>tmp_B_cell4_out(2),Cin=>tmp_cout_cell(2),Sin=>Sin_cell4(3),Cout=>Cout_cell4,Sout=>Sout_cell4(3),CLK=>CLK,RSTn=>RSTn,Aj_out=>A_cell4_out(3),Bi_out=>tmp_B_cell4_out(3));
 


end structural;
