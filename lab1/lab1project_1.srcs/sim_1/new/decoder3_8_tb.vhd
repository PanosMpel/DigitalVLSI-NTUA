----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2024 07:21:10 PM
-- Design Name: 
-- Module Name: decoder3_8_tb - testbench
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

entity decoder3_8_tb is
--  Port ( );
end decoder3_8_tb;

architecture testbench of decoder3_8_tb is
  component decoder3_8
    port (
      input: in std_logic_vector(2 downto 0); --inputs
      output: out std_logic_vector(7 downto 0) --outputs
    );
  end component;

  signal input_s : std_logic_vector(2 downto 0);  -- signals
  signal output_s : std_logic_vector(7 downto 0);  -- output signals

begin
  uut: decoder3_8
  port map (input => input_s, output => output_s);

  simulation : process
  begin
    input_s <= "000";
    wait for 10 ns;
    input_s <= "001";
    wait for 10 ns;
    input_s <= "010";
    wait for 10 ns;
    input_s <= "011";
    wait for 10 ns;
    input_s <= "100";
    wait for 10 ns;
    input_s <= "101";
    wait for 10 ns;
    input_s <= "110";
    wait for 10 ns;
    input_s <= "111";
    wait for 10 ns;
  end process;

end testbench;

