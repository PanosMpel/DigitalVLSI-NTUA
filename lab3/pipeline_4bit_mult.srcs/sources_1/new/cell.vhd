library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity cell is
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
end cell;
architecture Structural of cell is
signal a_tmp, cout_tmp, sout_tmp : STD_LOGIC;
signal and_out : STD_LOGIC;
component reg is
Port ( D : in STD_LOGIC;
CLK : in STD_LOGIC;
RSTn : in STD_LOGIC;
Q : out STD_LOGIC);
end component;
component Pipelined_Full_Adder is
Port (
c : in STD_LOGIC;
a : in STD_LOGIC;
b : in STD_LOGIC;
sum : out STD_LOGIC;
carry_out : out STD_LOGIC
);
end component;
begin
and_out<=Aj and Bi;
FA: Pipelined_Full_Adder port
map(c=>Cin,a=>Sin,b=>and_out,sum=>sout_tmp,carry_out=>cout_tmp);
reg_A1: reg port map(D=>Aj,CLK=>CLK,RSTn=>RSTn,Q=>a_tmp);
reg_A2: reg port map(D=>a_tmp,CLK=>CLK,RSTn=>RSTn,Q=>Aj_out);
reg_B: reg port map(D=>Bi,CLK=>CLK,RSTn=>RSTn,Q=>Bi_out);
reg_cout: reg port map(D=>cout_tmp,CLK=>CLK,RSTn=>RSTn,Q=>Cout);
reg_sout: reg port map(D=>sout_tmp,CLK=>CLK,RSTn=>RSTn,Q=>Sout);
end Structural;