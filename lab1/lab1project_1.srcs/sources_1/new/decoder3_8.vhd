----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2024 07:19:58 PM
-- Design Name: 
-- Module Name: decoder3_8 - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity decoder3_8 is
    port (
        input : in std_logic_vector(2 downto 0);
        output : out std_logic_vector(7 downto 0)
    );
end entity decoder3_8;

architecture behavioral of decoder3_8 is
begin
    process(input)
    begin
        case input is
            when "000" =>
                output <= "00000001";
            when "001" =>
                output <= "00000010";
            when "010" =>
                output <= "00000100";
            when "011" =>
                output <= "00001000";
            when "100" =>
                output <= "00010000";
            when "101" =>
                output <= "00100000";
            when "110" =>
                output <= "01000000";
            when "111" =>
                output <= "10000000";
            when others =>
                output <= (others => '0');
        end case;
    end process;
end architecture behavioral;