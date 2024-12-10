----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 10:14:04 PM
-- Design Name: 
-- Module Name: fulladder - Structural
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

entity fulladder is
    Port ( Af : in STD_LOGIC;
           Bf : in STD_LOGIC;
           Cf : in STD_LOGIC;
           Sumf : out STD_LOGIC;
           Carryf : out STD_LOGIC);
end fulladder;

architecture Structural of fulladder is

signal Sum1:std_logic;
signal Carry1:std_logic;
signal Carry2:std_logic;

component halfadder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Carry : out STD_LOGIC);
end component;
component or2 is
    Port ( a: in std_logic;
           b: in std_logic;
           c: out std_logic);
end component;
begin
halfadder1 : halfadder port map(A=>Af,B=>Bf,Sum=>Sum1,Carry=>Carry1);
halfadder2 : halfadder port map(A=>Sum1,B=>Cf,Sum=>Sumf,Carry=>Carry2);
Carryf<=Carry1 or Carry2;

end Structural;
