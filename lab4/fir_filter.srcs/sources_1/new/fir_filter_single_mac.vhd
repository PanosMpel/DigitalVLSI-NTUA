library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fir is 
 
 port (
 clk,valid_in,rst: in std_logic;
 x: in std_logic_vector (7 downto 0);
 y: out std_logic_vector (18 downto 0);
 valid_out: out std_logic
 );
end fir;
architecture fir_arch of fir is 
 component mac_unit is 
 port (
 clk,mac_init: in std_logic;
 rom_out, ram_out: in std_logic_vector(7 downto 0);
 result: out std_logic_vector(18 downto 0)
 );
 end component;
 
 component rom_unit is 
 port (
 clk,en : in STD_LOGIC;
 addr : in STD_LOGIC_VECTOR (2 downto 0);
 rom_out : out STD_LOGIC_VECTOR (7 downto 0)
 );
 
 end component; 
 component ram_unit is 
 port (
 clk,we,en,rst: in std_logic;
 addr : in std_logic_vector(2 downto 0);
 di : in std_logic_vector(7 downto 0);
 do : out std_logic_vector(7 downto 0)
 );
 
 end component;
 component control_unit is 
 port (
 clk,valid_in,rst: in std_logic;
 rom_addr,ram_addr: out std_logic_vector(2 downto 0);
 mac_init,we,en,valid_out: out std_logic
 );
 end component;
 
 signal reg_mac_init, mac_init_signal, en_signal, we_signal: std_logic;
 signal reg_x, rom_out_signal,ram_out_signal: std_logic_vector(7 downto 0);
 signal rom_addr_signal,ram_addr_signal: std_logic_vector(2 downto 0);
 begin
 mac: mac_unit port map(clk=>clk, mac_init=>reg_mac_init, 
rom_out=>rom_out_signal, ram_out=>ram_out_signal, result=>y);
 rom: rom_unit port map(clk=>clk, en=>en_signal, 
addr=>rom_addr_signal, rom_out=>rom_out_signal);
 ram: ram_unit port map(clk=>clk, we=>we_signal, en=>en_signal, 
rst=>rst, addr=>ram_addr_signal, di=>reg_x, do=>ram_out_signal);
 control: control_unit port map(clk=>clk, valid_in=>valid_in, 
rst=>rst, rom_addr=>rom_addr_signal, ram_addr=>ram_addr_signal, 
mac_init=>mac_init_signal, we=>we_signal, en=>en_signal, 
valid_out=>valid_out);
 
 process(clk)
 begin
 if(rising_edge(clk)) then
 reg_mac_init <= mac_init_signal;
 reg_x <= x;
 
 end if;
 end process;
 
end fir_arch;
