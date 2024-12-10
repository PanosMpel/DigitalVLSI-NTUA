----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 14:55:39
-- Design Name: 
-- Module Name: BCD_Full_Adder_tb - testbench
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

entity BCD_Full_Adder_tb is
--  Port ( );
end BCD_Full_Adder_tb;

architecture testbench of BCD_Full_Adder_tb is

    -- Signals for inputs
    signal bcd1_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal bcd2_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Cin_tb  : STD_LOGIC := '0';
    -- Signals for outputs
    signal Sumbcd_tb  : STD_LOGIC_VECTOR(3 downto 0);
    signal Coutbcd_tb : STD_LOGIC;
begin

 
    -- Instantiate the unit under test (UUT)
    UUT: entity work.BCD_Full_Adder
        port map (
            bcd1 => bcd1_tb,
            bcd2 => bcd2_tb,
            Cinbcd => Cin_tb,
            Sumbcd => Sumbcd_tb,
            Coutbcd => Coutbcd_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply inputs and observe outputs
        bcd1_tb <= "0000";  -- Input 0
        bcd2_tb <= "0000";  -- Input 0
        Cin_tb <= '0';      -- Carry-in 0
        wait for 10 ns;
        
        bcd1_tb <= "0001";  -- Input 1
        bcd2_tb <= "0001";  -- Input 1
        Cin_tb <= '0';      -- Carry-in 0
        wait for 10 ns;
        
        bcd1_tb <= "0010";  -- Input 2
        bcd2_tb <= "0011";  -- Input 3
        Cin_tb <= '1';      -- Carry-in 1
        wait for 10 ns;
        
        
        bcd1_tb <= "0110";
        bcd2_tb <= "0111";
        Cin_tb <= '0';
        wait for 10 ns;

        -- Add more test cases as needed

        wait;
    end process stim_proc;

end testbench;

