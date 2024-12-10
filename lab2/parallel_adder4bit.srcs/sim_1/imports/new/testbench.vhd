----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 08:43:29 PM
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
--  Port ( );
end testbench;

architecture arch_testbench of testbench is
    component halfadder
    port(
    A: in std_logic;
    B: in std_logic;
    Sum: out std_logic;
    Carry: out std_logic);
    end component;
    
    signal test_vector: std_logic_vector(1 downto 0);
    signal test_result : std_logic_vector(1 downto 0);
begin
uut: halfadder
port map(
    A=>test_vector(0),
    B=>test_vector(1),
    Sum=>test_result(0),
    Carry=>test_result(1)
);
testing: process
begin
test_vector<="00";
wait for 10ns;
test_vector<="01";
wait for 10ns;
test_vector<="10";
wait for 10ns;
test_vector<="11";
wait for 10ns;
end process;

end arch_testbench;
