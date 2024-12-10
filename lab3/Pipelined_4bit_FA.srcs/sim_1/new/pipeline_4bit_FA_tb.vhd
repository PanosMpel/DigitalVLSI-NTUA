library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity pipeline_4bit_FA_tb is
end pipeline_4bit_FA_tb;

architecture testbench of pipeline_4bit_FA_tb is

    -- Component declaration
    COMPONENT pipeline_4bit_FA is
        port(
a, b : in std_logic_vector(3 downto 0);
cin, clk, rst : in std_logic;
sum : out std_logic_vector(3 downto 0);
cout : out std_logic
);
    end COMPONENT;

    -- Signals for testbench
    signal A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal CLK : STD_LOGIC := '0';
    signal RSTn : STD_LOGIC := '1';  -- Active low reset
    signal Cin : STD_LOGIC := '0';
    signal Cout : STD_LOGIC := '0';  -- Initialize Cout
    signal S : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');  -- Initialize S

begin

    -- Instantiate the DUT
    UUT : pipeline_4bit_FA
    port map (
        a => A,
        b => B,
        clk => CLK,
        rst => RSTn,
        cin => Cin,
        cout => Cout,
        sum => S
    );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            CLK <= not CLK; -- Toggle clock
            wait for 5 ns; -- Clock period
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus: process
    begin
      
        RSTn <= '0';
    

        -- Test cases
        A <= "0000"; B <= "0000"; Cin <= '0'; wait for 20 ns;
        A <= "0001"; B <= "0001"; Cin <= '0'; wait for 20 ns;
        A <= "0010"; B <= "0010"; Cin <= '0'; wait for 20 ns;
        A <= "0100"; B <= "0011"; Cin <= '0'; wait for 20 ns;
        A <= "1111"; B <= "0001"; Cin <= '0'; wait for 20 ns;
        A <= "1101"; B <= "0011"; Cin <= '0'; wait for 20 ns;
        A <= "1011"; B <= "0101"; Cin <= '0'; wait for 20 ns;
        A <= "0101"; B <= "0111"; Cin <= '0'; wait for 20 ns;
        A <= "1101"; B <= "0001"; Cin <= '0'; wait for 20 ns;
        A <= "1101"; B <= "1011"; Cin <= '0'; wait for 20 ns;
        A <= "1010"; B <= "0101"; Cin <= '0'; wait for 20 ns;
        A <= "0100"; B <= "1111"; Cin <= '0'; wait for 20 ns;
        
        wait;
    end process;

end testbench;
