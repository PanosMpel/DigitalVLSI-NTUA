----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 03:48:42 PM
-- Design Name: 
-- Module Name: BCD_4digit_FA_tb - testbench
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
use IEEE.NUMERIC_STD.ALL;

entity BCD_4digit_FA_tb is
end BCD_4digit_FA_tb;

architecture testbench of BCD_4digit_FA_tb is

    -- Component declaration for the BCD_4digit_FA module
    component BCD_4digit_FA is
        Port (
            A : in STD_LOGIC_VECTOR (15 downto 0);
            B : in STD_LOGIC_VECTOR (15 downto 0);
            FinalCin : in STD_LOGIC;
            FinalSum : out STD_LOGIC_VECTOR (15 downto 0);
            FinalCout : out STD_LOGIC
        );
    end component;

    -- Inputs
    signal A_tb, B_tb : STD_LOGIC_VECTOR(15 downto 0);
    signal FinalCin_tb : STD_LOGIC;

    -- Outputs
    signal FinalSum_tb : STD_LOGIC_VECTOR(15 downto 0);
    signal FinalCout_tb : STD_LOGIC;

begin

    -- Instantiate the BCD_4digit_FA module
    UUT: BCD_4digit_FA port map (
        A => A_tb,
        B => B_tb,
        FinalCin => FinalCin_tb,
        FinalSum => FinalSum_tb,
        FinalCout => FinalCout_tb
    );

    -- Stimulus process
    stimulus: process
    begin
    
 
 
        A_tb <= "0000000000000101"; --59
        B_tb <= "0000000000000111"; --37
       FinalCin_tb <= '0';

        -- Wait for some time to observe outputs
        wait for 10 ns;

        -- End the simulation
        wait;
    end process stimulus;

end testbench;















 







