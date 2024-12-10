----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2024 03:35:27 AM
-- Design Name: 
-- Module Name: pipeline_4bit_FA - structural
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

entity pipeline_4bit_FA is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;
           RSTn : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (0 downto 0));
end pipeline_4bit_FA;

architecture structural of pipeline_4bit_FA is


signal tmp_cout : std_logic_vector(3 downto 0);
signal tmp_cin : std_logic_vector(2 downto 0);
signal tmp_S0 : std_logic_vector(3 downto 0);
signal tmp_S1 : std_logic_vector(2 downto 0);
signal tmp_S2 : std_logic_vector(1 downto 0);
signal tmp_S3 : std_logic;
signal tmp_A1 : std_logic;
signal tmp_B1 : std_logic;
signal tmp_A2 : std_logic_vector(1 downto 0);
signal tmp_B2 : std_logic_vector(1 downto 0);
signal tmp_A3 : std_logic_vector(2 downto 0);
signal tmp_B3 : std_logic_vector(2 downto 0);

component reg Port (
           D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RSTn : in STD_LOGIC;
           Q : out STD_LOGIC);
end  component;

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

FA_0: Pipelined_Full_Adder port map(c=>Cin,a=>A(0),b=>B(0),sum=>tmp_S0(0),carry_out=>tmp_cout(0));

FA_1: Pipelined_Full_Adder port map(c=>tmp_cin(0),a=>tmp_A1,b=>tmp_B1,sum=>tmp_S1(0),carry_out=>tmp_cout(1));

FA_2: Pipelined_Full_Adder port map(c=>tmp_cin(1),a=>tmp_A2(1),b=>tmp_B2(1),sum=>tmp_S2(0),carry_out=>tmp_cout(2));

FA_3: Pipelined_Full_Adder port map(c=>tmp_cin(2),a=>tmp_A3(2),b=>tmp_B3(2),sum=>tmp_S3,carry_out=>tmp_cout(3));



reg_s0_0: reg port map(D=>tmp_S0(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S0(1));
reg_s0_1: reg port map(D=>tmp_S0(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S0(2));
reg_s0_2: reg port map(D=>tmp_S0(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S0(3));
reg_s0_3: reg port map(D=>tmp_S0(3),CLK=>CLK,RSTn=>RSTn,Q=>S(0));

reg_s1_0: reg port map(D=>tmp_S1(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S1(1));
reg_s1_1: reg port map(D=>tmp_S1(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S1(2));
reg_s1_2: reg port map(D=>tmp_S1(2),CLK=>CLK,RSTn=>RSTn,Q=>S(1));

reg_s2_0: reg port map(D=>tmp_S2(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_S2(1));
reg_s2_1: reg port map(D=>tmp_S2(1),CLK=>CLK,RSTn=>RSTn,Q=>S(2));

reg_s3_1: reg port map(D=>tmp_S3,CLK=>CLK,RSTn=>RSTn,Q=>S(3));

reg_cout0: reg port map(D=>tmp_cout(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_cin(0));
reg_cout1: reg port map(D=>tmp_cout(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_cin(1));
reg_cout2: reg port map(D=>tmp_cout(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_cin(2));
reg_cout3: reg port map(D=>tmp_cout(3),CLK=>CLK,RSTn=>RSTn,Q=>Cout);

reg_A1: reg port map(D=>A(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A1);
reg_B1: reg port map(D=>B(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B1);

reg_A2_0: reg port map(D=>A(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A2(0));
reg_B2_0: reg port map(D=>B(2),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(0));
reg_A2_1: reg port map(D=>tmp_A2(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A2(1));
reg_B2_1: reg port map(D=>tmp_B2(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B2(1));

reg_A3_0: reg port map(D=>A(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A3(0));
reg_B3_0: reg port map(D=>B(3),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(0));
reg_A3_1: reg port map(D=>tmp_A3(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A3(1));
reg_B3_1: reg port map(D=>tmp_B3(0),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(1));
reg_A3_2: reg port map(D=>tmp_A3(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_A3(2));
reg_B3_2: reg port map(D=>tmp_B3(1),CLK=>CLK,RSTn=>RSTn,Q=>tmp_B3(2));


end structural;
