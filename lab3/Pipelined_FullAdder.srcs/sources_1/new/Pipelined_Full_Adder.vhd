----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2024 09:16:39
-- Design Name: 
-- Module Name: Pipelined_Full_Adder - Behavioral
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

entity Pipelined_Full_Adder is
Port ( cin : in STD_LOGIC;
sum : out STD_LOGIC;
a : in STD_LOGIC;
b : in STD_LOGIC;
cout : out STD_LOGIC);
end Pipelined_Full_Adder;

architecture Behavioral of Pipelined_Full_Adder is
begin

process(a,b,cin)
begin

if(a='0' and b='0' and cin='0')then
sum<='0';
cout<='0';
elsif( a='0' and b='0' and cin='1')then
sum<='1';
cout<='0';
elsif( a='0' and b='1' and cin='0')then
sum<='1';
cout<='0';
elsif( a='0' and b='1' and cin='1')then
sum<='0';
cout<='1';
elsif( a='1' and b='0' and cin='0')then
sum<='1';
cout<='0';
elsif( a='1' and b='0' and cin='1')then
sum<='0';
cout<='1';
elsif( a='1' and b='1' and cin='0')then
sum<='0';
cout<='1';
elsif ( a='1' and b='1' and cin='1')then
sum<='1';
cout<='1';
else
sum<='U';
cout<='U';
end if;

end process;
end Behavioral;








