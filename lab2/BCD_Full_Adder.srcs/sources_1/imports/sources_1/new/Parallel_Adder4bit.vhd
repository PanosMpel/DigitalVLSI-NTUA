----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 03:21:52
-- Design Name: 
-- Module Name: Parallel_Adder4bit - Structural
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

entity Parallel_Adder4bit is
 Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end Parallel_Adder4bit;
 
architecture Structural of Parallel_Adder4bit is
component fulladder is
     Port ( 
      Af : in STD_LOGIC;
      Bf : in STD_LOGIC;
      Cf : in STD_LOGIC;
      Sumf : out STD_LOGIC;
      Carryf : out STD_LOGIC
    );
end component;

signal Carry : std_logic_vector(3 downto 0);
 

begin
  FA0 : fulladder port map(Af=>A(0), Bf=>B(0), Cf=>Cin, Sumf=>Sum(0), Carryf=>Carry(0));
  FA1 : fulladder port map(Af=>A(1), Bf=>B(1), Cf=>Carry(0), Sumf=>Sum(1), Carryf=>Carry(1));
  FA2 : fulladder port map(Af=>A(2), Bf=>B(2), Cf=>Carry(1), Sumf=>Sum(2), Carryf=>Carry(2));
  FA3 : fulladder port map(Af=>A(3), Bf=>B(3), Cf=>Carry(2), Sumf=>Sum(3), Carryf=>Cout);
end Structural;