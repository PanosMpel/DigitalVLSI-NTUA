library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;  
 
entity ram_unit is 
 
  generic ( 
  data_width : integer :=8); 
 
    port ( 
          clk,we,en,rst:  in std_logic;    
          addr : in std_logic_vector(2 downto 0);    
          di   : in std_logic_vector(data_width-1 downto 0); 
          do   : out std_logic_vector(data_width-1 downto 0) );   
end ram_unit; 
 
    architecture behavioral of ram_unit is 
 
    type ram_type is array (7 downto 0) of std_logic_vector (data_width-1 downto 0); 
   
begin 

    process (clk,rst)  
        variable RAM : ram_type := (others => (others => '0')); 
    begin 
 
        if (rst='1') then 
            RAM := (others=> (others=>'0')); 
        elsif (rising_edge(clk)) then 
            if (en = '1') then 
                if (we = '1') then  
                    RAM(7 downto 1) := RAM(6 downto 0); -- shifts the contents of the RAM up by one position
                    RAM(0) := di; -- writes the input data di to the first location in the RAM
                    do <= di;
                else       
                    do <= RAM(conv_integer(addr)); 
                end if; 
            end if; 
        end if; 
    end process; 
 
end behavioral; 


      