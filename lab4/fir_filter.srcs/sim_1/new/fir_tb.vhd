LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY fir_tb IS 
END fir_tb;

ARCHITECTURE fir_tb_arch OF fir_tb IS 
    SIGNAL clk, valid_in, rst: std_logic := '0';
    SIGNAL x: std_logic_vector(7 downto 0) := (others=>'0');
    SIGNAL y: std_logic_vector(18 downto 0) := (others=>'0');
    SIGNAL valid_out: std_logic;

    COMPONENT fir IS
        PORT (
            clk, valid_in, rst: in std_logic;
            x: in std_logic_vector(7 downto 0);
            y: out std_logic_vector(18 downto 0);
            valid_out: out std_logic
        );
    END COMPONENT; 

BEGIN 
    DUT: fir PORT MAP(
        clk => clk,
        valid_in => valid_in,
        rst => rst,
        x => x,
        y => y, 
        valid_out => valid_out
    );

    CHANGE_RST: PROCESS
    begin
        rst <= '0';
        wait for 400 ns;
        rst <= '1';
        wait for 2 ns;
    END PROCESS;

    CLOCK: PROCESS
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    END PROCESS;

    CHANGE_X: PROCESS
    begin
        wait for 16 ns;
        x <= "11010000";
        wait for 16 ns;
        x <= "11100111";
        wait for 16 ns;
        x <= "00100000";
        wait for 16 ns;
        x <= "11101001";
        wait for 16 ns;
        x <= "10100001";
        wait for 16 ns;
        x <= "00011000";
        wait for 16 ns;
        x <= "01000111";
        wait for 16 ns;
        x <= "10001100";
        wait for 16 ns;
        x <= "11110101";
        wait for 16 ns;
        x <= "11110111";
        wait for 16 ns;
        x <= "00101000";
        wait for 16 ns;
        x <= "11111000";
        wait for 16 ns;
        x <= "11110101";
        wait for 16 ns;
        x <= "01111100";
        wait for 16 ns;
        x <= "11001100";
        wait for 16 ns;
        x <= "00100100";
        wait for 16 ns;
        x <= "01101011";
        wait for 16 ns;
        x <= "11101010";
        wait for 16 ns;
        x <= "11001010";
        wait for 16 ns;
        x <= "11110101";
    END PROCESS;

    CHANGE_VIN: PROCESS
    begin
        valid_in <= '1';
        wait for 1000 ns;
         
    END PROCESS;

END fir_tb_arch;