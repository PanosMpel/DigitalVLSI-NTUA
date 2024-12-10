----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 13:12:36
-- Design Name: 
-- Module Name: BCD_Full_Adder - Structural
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


 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 13:12:36
-- Design Name: 
-- Module Name: BCD_Full_Adder - Structural
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

entity BCD_Full_Adder is
    Port (
        bcd1 : in STD_LOGIC_VECTOR(3 downto 0);
        bcd2 : in STD_LOGIC_VECTOR(3 downto 0);
        Cin : in STD_LOGIC;
        
        Sum  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end BCD_Full_Adder;

architecture Structural of BCD_Full_Adder is

    -- Component declaration for the Parallel_Adder4bit
    component Parallel_Adder4bit is
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            Cin : in STD_LOGIC;
            Sum: out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    -- Signals for the first Parallel_Adder4bit
    signal sumFPD: std_logic_vector(3 downto 0); --Sum of first 
    signal CoutFPD : std_logic; --carry of first 

    -- Signals for the second Parallel_Adder4bit
    signal F : std_logic;
    signal second_value : std_logic_vector(3 downto 0);
    signal Cout_second : std_logic;

begin

    -- Instantiate the first Parallel_Adder4bit
    PA1 : Parallel_Adder4bit port map (
        A => bcd1,
        B => bcd2,
        Cin => Cin,
        Sum => sumFPD,
        Cout => CoutFPD
    );
    
 

    -- Calculate F based on your requirement (F = S3*S2 + S3*S1 + C3)
    F <= (sumFPD(3) and sumFPD(2)) or (sumFPD(3) and sumFPD(1)) or CoutFPD;

    -- Connect S3S2S1S0 to the output S
    second_value(0) <= '0';
    second_value(1) <= F;
    second_value(2) <= F;
    second_value(3) <= '0';

     
     

    -- Instantiate the second Parallel_Adder4bit
    PA2 : Parallel_Adder4bit port map (
        A => sumFPD,
        B => second_value,
        Cin => '0',  -- Connect Cin of the second adder to Cout of the first adder
        Sum => Sum,
        Cout => Cout_second 
    );
 Cout <= F;
end Structural;

