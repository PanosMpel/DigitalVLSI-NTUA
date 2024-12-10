----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 10:31:51 PM
-- Design Name: 
-- Module Name: testbench - arch_testbench
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

entity testbench is
    
end testbench;

architecture arch_testbench of testbench is
    component fulladder
    port ( Af : in STD_LOGIC;
           Bf : in STD_LOGIC;
           Cf : in STD_LOGIC;
           Sumf : out STD_LOGIC;
           Carryf : out STD_LOGIC);
    end component;
    
    signal test_vector: std_logic_vector(2 downto 0);
    signal test_result : std_logic_vector(1 downto 0);
    
begin
uut: fulladder
port map(
    Af=>test_vector(0),
    Bf=>test_vector(1),
    Cf=>test_vector(2),
    Sumf=>test_result(0),
    Carryf=>test_result(1)
);
testing: process
begin
wait for 10ns;
test_vector<="000";
wait for 10ns;
test_vector<="001";
wait for 10ns;
test_vector<="010";
wait for 10ns;
test_vector<="011";
wait for 10ns;
test_vector<="100";
wait for 10ns;
test_vector<="101";
wait for 10ns;
test_vector<="110";
wait for 10ns;
test_vector<="111";
wait for 10ns;
end process;

end arch_testbench;
