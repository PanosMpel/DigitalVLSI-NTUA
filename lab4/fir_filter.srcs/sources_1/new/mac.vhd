library IEEE; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all; 
 
 
entity mac_unit is  
 
    port ( 
        clk,mac_init: in std_logic; 
        rom_out, ram_out: in std_logic_vector(7 downto 0); 
        result: out std_logic_vector(18 downto 0) 
 
    ); 
 
end mac_unit; 
 
architecture mac_unit_beh of mac_unit is  
 
    begin 
        process(clk) 
         
        variable acc: std_logic_vector(18 downto 0) := (others=>'0'); 
        begin 
         
            if (rising_edge(clk)) then             
                if (mac_init='1') then 
                    acc := (others=>'0'); 
                    acc(15 downto 0) := rom_out * ram_out;                      
                else 
                    acc := acc + rom_out * ram_out;                 
                end if;                  
                result <= acc; 
 
            end if;         
        end process; 
         
end mac_unit_beh; 