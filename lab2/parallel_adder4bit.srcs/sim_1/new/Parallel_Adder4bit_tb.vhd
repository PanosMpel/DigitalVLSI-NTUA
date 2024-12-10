----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 03:29:12
-- Design Name: 
-- Module Name: Parallel_Adder4bit_tb - testbench
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


entity Parallel_Adder4bit_tb is
--  Port ( );
end Parallel_Adder4bit_tb;

architecture testbench of Parallel_Adder4bit_tb is

    -- Component declaration for the DUT (Device Under Test)
    component Parallel_Adder4bit
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            Cin : in STD_LOGIC;
            Sum : out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    -- Signals for stimulus generation and result capturing
    signal A_tb, B_tb: STD_LOGIC_VECTOR(3 downto 0);
    signal Cin_tb, Cout_tb: STD_LOGIC;
    signal Sum_tb: STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    uut: Parallel_Adder4bit port map (
        A => A_tb,
        B => B_tb,
        Cin => Cin_tb,
        Sum => Sum_tb,
        Cout => Cout_tb
    );

   -- Stimulus process
    stimulus: process
   begin
        for i in 0 to 15 loop
            for j in 0 to 15 loop
               
                        A_tb <= std_logic_vector(to_unsigned(i, 4));
                        B_tb <= std_logic_vector(to_unsigned(j, 4));
                        Cin_tb <= '0';
                        wait for 1  ns;
                        Cin_tb <= '1';
                        wait for 1  ns;
 
                
            end loop;
        end loop;
        -- End of test
        wait;
end process stimulus;
end testbench;
