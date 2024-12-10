----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 03:15:57 PM
-- Design Name: 
-- Module Name: BCD_4digit_FA - Structural
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

entity BCD_4digit_FA is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           FinalCin : in STD_LOGIC;
           FinalSum : out STD_LOGIC_VECTOR (15 downto 0);
           FinalCout : out STD_LOGIC);
end BCD_4digit_FA;

architecture Structural of BCD_4digit_FA is

component BCD_Full_adder is
Port (
        bcd1 : in STD_LOGIC_VECTOR(3 downto 0);
        bcd2 : in STD_LOGIC_VECTOR(3 downto 0);
        Cin : in STD_LOGIC;
        
        Sum  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end component;
signal Carry : std_logic_vector(2 downto 0);

begin
  BCD0 :  BCD_Full_adder port map(bcd1=>A(3 downto 0), bcd2=>B(3 downto 0), Cin=>FinalCin, Sum=>FinalSum(3 downto 0), Cout=>Carry(0));
  BCD1 :  BCD_Full_adder port map(bcd1=>A(7 downto 4), bcd2=>B(7 downto 4), Cin=>Carry(0), Sum=>FinalSum(7 downto 4), Cout=>Carry(1));
  BCD2 :  BCD_Full_adder port map(bcd1=>A(11 downto 8), bcd2=>B(11 downto 8), Cin=>Carry(1), Sum=>FinalSum(11 downto 8), Cout=>Carry(2));
  BCD3 :  BCD_Full_adder port map(bcd1=>A(15 downto 12), bcd2=>B(15 downto 12), Cin=>Carry(2), Sum=>FinalSum(15 downto 12), Cout=>FinalCout);

end Structural;
