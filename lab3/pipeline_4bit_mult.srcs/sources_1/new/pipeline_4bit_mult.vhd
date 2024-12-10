library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pipeline_4bit_mult is
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
P : out STD_LOGIC_VECTOR (7 downto 0);
-- Cinall : in STD_LOGIC_VECTOR (3 downto 0);
CLK : in STD_LOGIC; -- Added CLK signal to port list
RSTn : in STD_LOGIC -- Added RSTn signal to port list
-- Sinall : in STD_LOGIC_VECTOR (3 downto 0)
);
end pipeline_4bit_mult;
architecture structural of pipeline_4bit_mult is
signal tmp_B1 : std_logic_vector(1 downto 0);
signal tmp_B2 : std_logic_vector(3 downto 0);
signal tmp_B3 : std_logic_vector(5 downto 0);
signal tmp_P4 : STD_LOGIC;
signal tmp_P3 : std_logic_vector(1 downto 0);
signal tmp_P2 : std_logic_vector(3 downto 0);
signal tmp_P1 : std_logic_vector(5 downto 0);
signal tmp_P0 : std_logic_vector(7 downto 0);
signal cout_cell4 : std_logic_vector(3 downto 0);
signal cout_cell4_delay : std_logic_vector(3 downto 0);
signal A0_first_delay :STD_LOGIC;
signal B0_first_delay :STD_LOGIC;
signal A1_first_delay :STD_LOGIC;
signal A2_first_delay : std_logic_vector(1 downto 0);
signal A3_first_delay : std_logic_vector(2 downto 0);
signal cout_first_4_parallel : std_logic_vector(3 downto 0); ---cout
--ths ka8e tetradas gia thn prwth
signal cout_second_4_parallel : std_logic_vector(3 downto 0); ---cout
--ths ka8e tetradas gia thn deyterh
signal cout_third_4_parallel : std_logic_vector(3 downto 0); ---cout
--ths ka8e tetradas gia thn trith
signal cout_fourth_4_parallel : std_logic_vector(3 downto 0); ---cout
--ths ka8e tetradas gia thn tetarti
signal b0_output : std_logic_vector(3 downto 0);
signal b1_output : std_logic_vector(3 downto 0);
signal b2_output : std_logic_vector(3 downto 0);
signal b3_output : std_logic_vector(3 downto 0);
signal a0_output : std_logic_vector(3 downto 0);
signal a1_output : std_logic_vector(3 downto 0);
signal a2_output : std_logic_vector(3 downto 0);
signal a3_output : std_logic_vector(3 downto 0);
signal Sout_cell : std_logic_vector(15 downto 0);
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
----------------------Delay for B2
reg_B2_1_delay_shift: reg port
map(D=>B(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(0));
reg_B2_2_Delay_shift: reg port
map(D=>tmp_B2(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(1));
reg_B2_3_Delay_shift: reg port
map(D=>tmp_B2(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(2));
reg_B2_4_Delay_shift: reg port
map(D=>tmp_B2(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(3));
------------------------------DElay for B3
reg_B3_1_delay_shift: reg port
map(D=>B(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(0));
reg_B3_2_delay_shift: reg port
map(D=>tmp_B3(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(1));
reg_B3_3_delay_shift: reg port
map(D=>tmp_B3(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(2));
reg_B3_4_delay_shift: reg port
map(D=>tmp_B3(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(3));
reg_B3_5_delay_shift: reg port
map(D=>tmp_B3(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(4));
reg_B3_6_delay_shift: reg port
map(D=>tmp_B3(4),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(5));
-------------------------CELLS------------------------------------------
--------------------FIRST 4PARALLEL
cell_1_first_4_parallel: cell port map(
Aj=>A(0),
Bi=>B(0),
Cin=>'0',
Sin=>'0',
Cout=>cout_first_4_parallel(0),
Sout=>Sout_cell(0),
CLK=>CLK,
Aj_out=>a0_output(0),
Bi_out=>b0_output(0),
RSTn=>RSTn);
---------------------------delay for A1
reg_A1_1_first_delay: reg port map(D=>A(1)
,CLK=>CLK,RSTn=>RSTn,Q=>A1_first_delay);
cell_2_first_4_parallel: cell port map(
Aj=>A1_first_delay,
Bi=>b0_output(0),
Cin=>cout_first_4_parallel(0),
Sin=>'0',
Cout=>cout_first_4_parallel(1),
Sout=>Sout_cell(1),
CLK=>CLK,
Aj_out=>a1_output(0),
Bi_out=>b0_output(1),
RSTn=>RSTn);
----------------------Delay for A2
reg_A2_1_first_delay: reg port map(D=>A(2)
,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(0));
reg_A2_2_first_delay: reg port map(D=>A2_first_delay(0)
,CLK=>CLK,RSTn=>RSTn,Q=>A2_first_delay(1));
cell_3_first_4_parallel: cell port map(
Aj=>A2_first_delay(1),
Bi=>b0_output(1),
Cin=>cout_first_4_parallel(1),
Sin=>'0',
Cout=>cout_first_4_parallel(2),
Sout=>Sout_cell(2),
CLK=>CLK,
Aj_out=>a2_output(0),
Bi_out=>b0_output(2),
RSTn=>RSTn);
----------------------Delay for A3
reg_A3_1_first_delay: reg port map(D=>A(3)
,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(0));
reg_A3_2_first_delay: reg port map(D=>A3_first_delay(0)
,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(1));
reg_A3_3_first_delay: reg port map(D=>A3_first_delay(1)
,CLK=>CLK,RSTn=>RSTn,Q=>A3_first_delay(2));
cell_4_first_4_parallel: cell port map(
Aj=>A3_first_delay(2),
Bi=>b0_output(2),
Cin=>cout_first_4_parallel(2),
Sin=>'0',
Cout=>cout_first_4_parallel(3),
Sout=>Sout_cell(3),
CLK=>CLK,
Aj_out=>a3_output(0),
Bi_out=>b0_output(3),
RSTn=>RSTn);
--------------------SECOND 4PARALLEL
------------DElay for cout_cell4_delay_first
reg_cout_cell4_delay_first: reg port map(D=>cout_first_4_parallel(3)
,CLK=>CLK,RSTn=>RSTn,Q=>cout_cell4_delay(0));
-----------------Delay for B1
reg_B1_1delay_shift: reg port map(D=>B(1)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_B1(0));
reg_B1_2_delay_shift: reg port map(D=>tmp_B1(0)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_B1(1));

cell_1_second_4_parallel: cell port map(
Aj=>a0_output(0),
Bi=>tmp_B1(1) ,
Cin=>'0',
Sin=>Sout_cell(1),
Cout=>cout_second_4_parallel(0),
Sout=>Sout_cell(4),
CLK=>CLK,
Aj_out=>a0_output(1),
Bi_out=>b1_output(0),
RSTn=>RSTn);

cell_2_second_4_parallel: cell port map(
Aj=>a1_output(0),
Bi=>b1_output(0) ,
Cin=>cout_second_4_parallel(0),
Sin=>Sout_cell(2),
Cout=>cout_second_4_parallel(1),
Sout=>Sout_cell(5),
CLK=>CLK,
Aj_out=>a1_output(1),
Bi_out=>b1_output(1),
RSTn=>RSTn);

cell_3_second_4_parallel: cell port map(
Aj=>a2_output(0),
Bi=>b1_output(1),
Cin=>cout_second_4_parallel(1),
Sin=>Sout_cell(3),
Cout=>cout_second_4_parallel(2),
Sout=>Sout_cell(6),
CLK=>CLK,
Aj_out=>a2_output(1),
Bi_out=>b1_output(2),
RSTn=>RSTn);

cell_4_second_4_parallel: cell port map(
Aj=>a3_output(0),
Bi=>b1_output(2),
Cin=>cout_second_4_parallel(2),
Sin=>cout_cell4_delay(0),
Cout=>cout_second_4_parallel(3),
Sout=>Sout_cell(7),
CLK=>CLK,
Aj_out=>a3_output(1),
Bi_out=>b1_output(3),
RSTn=>RSTn);
--------------------THIRD 4PARALLEL
------------------------DElay for cout_cell4_delay_second
reg_cout_cell4_delay_second: reg port map(D=>cout_second_4_parallel(3)
,CLK=>CLK,RSTn=>RSTn,Q=>cout_cell4_delay(1));

cell_1_third_4_parallel: cell port map(
Aj=>a0_output(1),
Bi=>tmp_B2(3) ,
Cin=>'0',
Sin=>Sout_cell(5),
Cout=>cout_third_4_parallel(0),
Sout=>Sout_cell(8),
CLK=>CLK,
Aj_out=>a0_output(2),
Bi_out=>b2_output(0),
RSTn=>RSTn);

cell_2_third_4_parallel: cell port map(
Aj=>a1_output(1),
Bi=>b2_output(0) ,
Cin=>cout_third_4_parallel(0),
Sin=>Sout_cell(6),
Cout=>cout_third_4_parallel(1),
Sout=>Sout_cell(9),
CLK=>CLK,
Aj_out=>a1_output(2),
Bi_out=>b2_output(1),
RSTn=>RSTn);

cell_3_third_4_parallel: cell port map(
Aj=>a2_output(1),
Bi=>b2_output(1),
Cin=>cout_third_4_parallel(1),
Sin=>Sout_cell(7),
Cout=>cout_third_4_parallel(2),
Sout=>Sout_cell(10),
CLK=>CLK,
Aj_out=>a2_output(2),
Bi_out=>b2_output(2),
RSTn=>RSTn);

cell_4_third_4_parallel: cell port map(
Aj=>a3_output(1),
Bi=>b2_output(2),
Cin=>cout_third_4_parallel(2),
Sin=>cout_cell4_delay(1),
Cout=>cout_third_4_parallel(3),
Sout=>Sout_cell(11),
CLK=>CLK,
Aj_out=>a3_output(2),
Bi_out=>b2_output(3),
RSTn=>RSTn);
--------------------FOURTH 4PARALLEL
----------------------Delay for cout_cell4_delay_third
reg_cout_cell4_delay_third: reg port map(D=>cout_third_4_parallel(3)
,CLK=>CLK,RSTn=>RSTn,Q=>cout_cell4_delay(2));

cell_1_fourth_4_parallel: cell port map(
Aj=>a0_output(2),
Bi=>tmp_B3(5) ,
Cin=>'0',
Sin=>Sout_cell(9),
Cout=>cout_fourth_4_parallel(0),
Sout=>Sout_cell(12),
CLK=>CLK,
Aj_out=>a0_output(3),
Bi_out=>b3_output(0),
RSTn=>RSTn);

cell_2_fourth_4_parallel: cell port map(
Aj=>a1_output(2),
Bi=>b3_output(0),
Cin=>cout_fourth_4_parallel(0),
Sin=>Sout_cell(10),
Cout=>cout_fourth_4_parallel(1),
Sout=>Sout_cell(13),
CLK=>CLK,
Aj_out=>a1_output(3),
Bi_out=>b3_output(1),
RSTn=>RSTn);

cell_3_fourth_4_parallel: cell port map(
Aj=>a2_output(2),
Bi=>b3_output(1),
Cin=>cout_fourth_4_parallel(1),
Sin=>Sout_cell(11),
Cout=>cout_fourth_4_parallel(2),
Sout=>Sout_cell(14),
CLK=>CLK,
Aj_out=>a2_output(3),
Bi_out=>b3_output(2),
RSTn=>RSTn);

cell_4_fourth_4_parallel: cell port map(
Aj=>a3_output(2),
Bi=>b3_output(2),
Cin=>cout_fourth_4_parallel(2),
Sin=>cout_cell4_delay(2),
Cout=>cout_fourth_4_parallel(3),
Sout=>Sout_cell(15),
CLK=>CLK,
Aj_out=>a3_output(3),
Bi_out=>b3_output(3),
RSTn=>RSTn);

----9 DELAY FOR Sout from first cell (P(0))
reg_P01_Delay: reg port
map(D=>Sout_cell(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(0));
reg_P02_Delay: reg port
map(D=>tmp_P0(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(1));
reg_P03_Delay: reg port
map(D=>tmp_P0(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(2));
reg_P04_Delay: reg port
map(D=>tmp_P0(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(3));
reg_P05_Delay: reg port
map(D=>tmp_P0(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(4));
reg_P06_Delay: reg port
map(D=>tmp_P0(4),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(5));
reg_P07_Delay: reg port
map(D=>tmp_P0(5),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P0(6));
reg_P08_Delay: reg port map(D=>tmp_P0(6),CLK=>CLK,RSTn=>RSTn,Q=>P(0));
-- reg_P09_Delay: reg port
--map(D=>tmp_P0(7),CLK=>CLK,RSTn=>RSTn,Q=>P(0));

----7 DELAY FOR Sout from first cell FROM second cell4 parallel (P(1))
reg_P11_Delay: reg port
map(D=>Sout_cell(4),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P1(0));
reg_P12_Delay: reg port
map(D=>tmp_P1(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P1(1));
reg_P13_Delay: reg port
map(D=>tmp_P1(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P1(2));
reg_P14_Delay: reg port
map(D=>tmp_P1(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P1(3));
reg_P15_Delay: reg port
map(D=>tmp_P1(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_P1(4));
reg_P16_Delay: reg port map(D=>tmp_P1(4),CLK=>CLK,RSTn=>RSTn,Q=>P(1));
--reg_P17_Delay: reg port map(D=>tmp_P1(5),CLK=>CLK,RSTn=>RSTn,Q=>P(1));

----5 DELAY FOR Sout from first cell FROM third cell4 parallel (P(2))
reg_P21_Delay: reg port map(D=>Sout_cell(8)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P2(0));
reg_P22_Delay: reg port map(D=>tmp_P2(0)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P2(1));
reg_P23_Delay: reg port map(D=>tmp_P2(1)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P2(2));
reg_P24_Delay: reg port map(D=>tmp_P2(2)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P2(3));
reg_P25_Delay: reg port map(D=>tmp_P2(3) ,CLK=>CLK,RSTn=>RSTn,Q=>P(2));

----3 DELAY FOR Sout from first cell FROM -four cell4 parallel (P(3))
reg_P31_Delay: reg port map(D=>Sout_cell(12)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P3(0));
reg_P32_Delay: reg port map(D=>tmp_P3(0)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P3(1));
reg_P33_Delay: reg port map(D=>tmp_P3(1) ,CLK=>CLK,RSTn=>RSTn,Q=>P(3));

----2 DELAY FOR Sout from second cell FROM -four cell4 parallel (P(4))
reg_P41_Delay: reg port map(D=>Sout_cell(13)
,CLK=>CLK,RSTn=>RSTn,Q=>tmp_P4);
reg_P42_Delay: reg port map(D=>tmp_P4 ,CLK=>CLK,RSTn=>RSTn,Q=>P(4));

----1 DELAY FOR Sout from third cell FROM -four cell4 parallel (P(5))
reg_P5_Delay: reg port map(D=>Sout_cell(14)
,CLK=>CLK,RSTn=>RSTn,Q=>P(5));

-- 0 delay for P6, P7
P(6)<=Sout_cell(15) ;
P(7)<= cout_fourth_4_parallel(3) ;
end structural;