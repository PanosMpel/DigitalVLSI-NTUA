library IEEE; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
entity control_unit is  
 
    port ( 
       clk, valid_in, rst: in std_logic; 
       rom_addr, ram_addr: out std_logic_vector(2 downto 0); 
       mac_init, we, en, valid_out: out std_logic 
    ); 
 
end control_unit; 
 
architecture control_unit_beh of control_unit is  
 
    signal reg_valid_out: std_logic_vector(8 downto 0) := 
(others=>'0'); 
    signal counter: std_logic_vector(2 downto 0) := "000"; 
     
    begin 
 
        process(clk,rst) 
        begin 
                                
            if (rst='1') then  
 
                counter <= "000"; 
                ram_addr <= "000"; 
                rom_addr <= "000"; 
                reg_valid_out <= (others => '0');
                 
 
            elsif (rising_edge(clk)) then  
                        
                    if (counter="000") and (valid_in='1')then  
 
                        mac_init <= '1'; 
                        we <= '1'; 
                        en <= '1'; 
                       reg_valid_out(0) <= '1';

                        --freeze<='1';
                        valid_out <= reg_valid_out(8);
                       reg_valid_out(8 downto 1) <= reg_valid_out(7 downto 0); 
                    elsif (counter="000") and (valid_in='0')then
                        mac_init <= '1'; 
                        en <= '0'; 
                        we <= '0'; 
                      reg_valid_out(0) <= '0'; 
                      valid_out <= reg_valid_out(8);
                      reg_valid_out(8 downto 1) <= reg_valid_out(7 downto 0); 
                      --   freeze<='0';
                   elsif counter="001" then
                      en <= '1'; 
                      we <= '0'; 
                      mac_init <= '0'; 
                      reg_valid_out(0) <= '0';
                      valid_out <= reg_valid_out(8);
                      reg_valid_out(8 downto 1) <= reg_valid_out(7 downto 0); 
                   else
                      en <= '1'; 
                      we <= '0'; 
                      mac_init <= '0'; 
                      valid_out <= reg_valid_out(8);
                      reg_valid_out(8 downto 1) <= reg_valid_out(7 downto 0); 


                    end if; 
            if counter/=7 then
                counter<=counter+1;
            else
               counter<=(others=>'0');
            end if;

              ram_addr <= counter; 
              rom_addr <= counter; 
                
              
            end if; 
               
      end process; 
         
end control_unit_beh;