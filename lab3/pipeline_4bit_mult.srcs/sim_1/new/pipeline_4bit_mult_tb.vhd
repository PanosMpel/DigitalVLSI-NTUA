library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pipeline_4bit_mult_tb is
end pipeline_4bit_mult_tb;
architecture Behavioral of pipeline_4bit_mult_tb is
-- Component declaration
component pipeline_4bit_mult
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
P : out STD_LOGIC_VECTOR (7 downto 0);
--Cinall : in STD_LOGIC_VECTOR (3 downto 0);
CLK : in STD_LOGIC;
RSTn : in STD_LOGIC
-- Sinall : in STD_LOGIC_VECTOR (3 downto 0)
);
end component;
-- Signals declaration
signal A_sig : STD_LOGIC_VECTOR (3 downto 0);
signal B_sig : STD_LOGIC_VECTOR (3 downto 0);
signal P_sig : STD_LOGIC_VECTOR (7 downto 0);
signal Cinall_sig : STD_LOGIC_VECTOR (3 downto 0);
signal CLK_sig : STD_LOGIC := '0'; -- Clock signal
signal RSTn_sig : STD_LOGIC := '1'; -- Reset signal
signal Sinall_sig : STD_LOGIC_VECTOR (3 downto 0);
begin
-- Instantiate the pipeline_4bit_mult module
UUT : pipeline_4bit_mult port map(
A => A_sig,
B => B_sig,
P => P_sig,
-- Cinall => Cinall_sig,
CLK => CLK_sig,
RSTn => RSTn_sig
-- Sinall => Sinall_sig
);
-- Clock process
CLK_process: process
begin
while now < 1000 ns loop
CLK_sig <= not CLK_sig; -- Toggle clock
wait for 5 ns; -- Clock period
end loop;
wait;
end process;
-- Stimulus process
stimulus_process: process
begin
-- Reset initialization
RSTn_sig <= '1';
-- Initial values
A_sig <= "1010"; B_sig <= "1011"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1110"; B_sig <= "1111"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1111"; B_sig <= "1101"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1010"; B_sig <= "1011"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Additional values
A_sig <= "0010"; B_sig <= "1101"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
A_sig <= "0101"; B_sig <= "1001"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
A_sig <= "0001"; B_sig <= "1110"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
A_sig <= "0110"; B_sig <= "0101"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1010"; B_sig <= "1011"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1110"; B_sig <= "1111"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1111"; B_sig <= "1101"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
-- Next values
A_sig <= "1010"; B_sig <= "1011"; Cinall_sig <= "0000"; Sinall_sig <=
"0000"; wait for 100 ns;
wait;
end process;
end Behavioral;