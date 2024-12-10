library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity rom_unit is
generic (
coeff_width : integer :=8 
);

 port ( 
 clk : in STD_LOGIC;
 en : in STD_LOGIC;
 addr : in STD_LOGIC_VECTOR (2 downto 0);
 rom_out : out STD_LOGIC_VECTOR (coeff_width-1 downto 0)
 );
 
end rom_unit;

architecture behavioral of rom_unit is

 type rom_type is array (7 downto 0) of std_logic_vector (coeff_width-1 downto 0); 
 
 signal rom: rom_type:= ("00001000", "00000111", "00000110", 
"00000101", "00000100", "00000011", "00000010", "00000001"); 
 
 signal rdata: std_logic_vector(coeff_width-1 downto 0) := (others => '0');
 begin
 
 rdata <= rom(conv_integer(addr));
 
 process (clk)
 begin
 
 if (rising_edge(clk)) then
 if (en = '1') then
 rom_out <= rdata;
 end if;
 end if;
 end process;
end behavioral;
