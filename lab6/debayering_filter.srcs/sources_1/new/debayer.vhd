library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity debayer is
  generic( N: integer := 32);
  Port (
  clk : IN STD_LOGIC;
  rst: IN STD_LOGIC;
  s2p_00 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_01 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_02 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_10 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_11 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_12 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_20 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_21 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  s2p_22 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  line_img : IN std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
  column_img : IN std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
  R : out std_logic_vector(7 downto 0);
  G : out std_logic_vector(7 downto 0);
  B : out std_logic_vector(7 downto 0) 
  );
end debayer;

architecture Behavioral of debayer is

signal box_00, box_01, box_02, box_10, box_11, box_12, box_20, box_21, box_22 : std_logic_vector(7 downto 0);
signal add_outer, add_cross,add_row,add_col : std_logic_vector(7 downto 0);
signal add_row_bef, add_col_bef: std_logic_vector(8 downto 0);
signal add_outer_bef, add_cross_bef: std_logic_vector(9 downto 0);
signal unsigned_x1,unsigned_x2,unsigned_x3,unsigned_x4 : unsigned(7 downto 0);
signal sum_unsigned : unsigned(8 downto 0);
signal divided_unsigned : unsigned(8 downto 0);
signal sum_unsigned_2 : unsigned(9 downto 0);
--constant N : integer := 32;
begin 

box_00 <= s2p_22 when to_integer(unsigned(line_img)) /= 0 and to_integer(unsigned(column_img)) /= 0 else (others => '0'); ----- ????? ???? ????????
box_01 <= s2p_21 when to_integer(unsigned(line_img)) /= 0  else (others => '0');
box_02 <= s2p_20 when to_integer(unsigned(line_img)) /= 0 and to_integer(unsigned(column_img)) /=  N-1 else (others => '0'); ----- ????? ???? ?????
box_10 <= s2p_12 when to_integer(unsigned(column_img)) /= 0 else (others => '0');
box_11 <= s2p_11;
box_12 <= s2p_10 when to_integer(unsigned(column_img)) /= N-1 else (others => '0');
box_20 <= s2p_02 when to_integer(unsigned(line_img)) /= N-1 and to_integer(unsigned(column_img)) /= 0 else (others => '0'); ----- ????? ????  ????????
box_21 <= s2p_01 when to_integer(unsigned(line_img)) /= N-1  else (others => '0');
box_22 <= s2p_00 when to_integer(unsigned(line_img)) /= N-1 and to_integer(unsigned(column_img)) /= N-1 else (others => '0'); ----- ????? ????  ?????



add_row_bef <= ('0' & box_10) + ('0' & box_12); --kanw to add_row_bef 9 bits
add_row <= add_row_bef(8 downto 1); -- me leftshift kanw /2
 
add_col_bef <= ('0' & box_01) + ('0' & box_21);
add_col <= add_col_bef(8 downto 1);
 
add_cross_bef <= ("00" & box_01) + ("00" & box_10) + ("00" & box_12) + ("00" & box_21);
add_cross <= add_cross_bef(9 downto 2); -- 2 leftshift ara kanw /4
 
add_outer_bef <= ("00" & box_00) + ("00" & box_02) + ("00" & box_20) + ("00" & box_22);
add_outer <= add_outer_bef(9 downto 2);
 

 process(clk,rst)
    begin
        if rising_edge(clk)  then
            if line_img(0) = '0' and column_img(0) = '0' then  -- (ii)
                    R <= add_col;
                    G <= box_11;
                    B <= add_row;
            elsif line_img(0) = '0' and column_img(0) = '1' then --(iv)
                    R <= add_outer;
                    G <= add_cross;
                    B <= box_11;
           elsif line_img(0) = '1' and column_img(0) = '0' then  --(iii)
                   R <= box_11;
                   G <= add_cross;
                   B <= add_outer;
           elsif line_img(0) = '1' and column_img(0) = '1' then   --(i)
                  R <= add_row;
                  G <= box_11;
                  B <= add_col;
           end if;  
           end if;          
      end process;
end Behavioral;