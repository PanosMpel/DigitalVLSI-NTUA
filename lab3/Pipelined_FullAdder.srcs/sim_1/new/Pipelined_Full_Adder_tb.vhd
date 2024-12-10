 



--library IEEE;






--use IEEE.STD_LOGIC_1164.ALL;

--entity  Pipelined_Full_Adder_tb is
--end Pipelined_Full_Adder_tb;

--architecture testbench of Pipelined_Full_Adder_tb is
      -- Signals
   -- signal c_tb, a_tb, b_tb : std_logic;
   -- signal sum_out, carry_out_out : std_logic;

--begin
    -- Component instantiation
  --  UUT: entity work.Pipelined_Full_Adder 
   --     port map(
   --         c => c_tb,
    --        a => a_tb,
    --        b => b_tb,
      --      sum => sum_out,
      --      carry_out => carry_out_out
    --    );

    -- Stimulus process
  --  stimulus_proc: process
  --  begin
    --      c_tb <= '0';
     --   a_tb <= '0';
     --   b_tb <= '0';
    --    wait for 10ns;
        
        -- Test case 1: 0 + 0 + 0
     --   a_tb <= '0';
     --   b_tb <= '0';
    --    c_tb <= '0';
    --    wait for 10 ns;

        -- Test case 2: 0 + 0 + 1
    --    a_tb <= '0';
     --   b_tb <= '0';
   --     c_tb <= '1';
     --   wait for 10 ns;

        -- Test case 3: 0 + 1 + 0
    --    a_tb <= '0';
     --   b_tb <= '1';
    --    c_tb <= '0';
     --   wait for 10ns;

        -- Test case 4: 0 + 1 + 1
      --  a_tb <= '0';
    --    b_tb <= '1';
     --   c_tb <= '1';
      --  wait for 10 ns;

        -- Test case 5: 1 + 0 + 0
     --   a_tb <= '1';
     --   b_tb <= '0';
    --    c_tb <= '0';
    --    wait for 10 ns;

        -- Test case 6: 1 + 0 + 1
     --   a_tb <= '1';
     --   b_tb <= '0';
    --    c_tb <= '1';
    --    wait for 10ns;

        -- Test case 7: 1 + 1 + 0
    --    a_tb <= '1';
    --    b_tb <= '1';
    --    c_tb <= '0';
    --    wait for 10 ns;

        -- Test case 8: 1 + 1 + 1
    --    a_tb <= '1';
    --    b_tb <= '1';
    --    c_tb <= '1';
     --    wait for 10 ns;
    --    wait;
  --  end process stimulus_proc;

--end testbench;

 

 
-----------------test bench
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Pipelined_Full_Adder_tb is
end;

architecture bench of Pipelined_Full_Adder_tb is

  component Pipelined_Full_Adder
  Port ( cin : in STD_LOGIC;
  sum : out STD_LOGIC;
  a : in STD_LOGIC;
  b : in STD_LOGIC;
  cout : out STD_LOGIC);
  end component;

  signal cin: STD_LOGIC;
  signal sum: STD_LOGIC;
  signal a: STD_LOGIC;
  signal b: STD_LOGIC;
  signal cout: STD_LOGIC;

begin

  uut: Pipelined_Full_Adder port map ( cin  => cin,
                      sum  => sum,
                      a    => a,
                      b    => b,
                      cout => cout );

  stimulus: process
  begin
  
   A <= '0';
  B <= '0';
  Cin <= '0';
  wait for 10 ns;
  
  A <= '0';
  B <= '0';
  Cin <= '1';
  wait for 10 ns;
  
  A <= '0';
  B <= '1';
  Cin <= '0';
  wait for 10 ns;
  
  A <= '0';
  B <= '1';
  Cin <= '1';
  wait for 10 ns;
  
  A <= '1';
  B <= '0';
  Cin <= '0';
  wait for 10 ns;
  
  A <= '1';
  B <= '0';
  Cin <= '1';
  wait for 10 ns;
  
  A <= '1';
  B <= '1';
  Cin <= '0';
  wait for 10 ns;
  
  A <= '1';
  B <= '1';
  Cin <= '1';
  wait for 10 ns;

    wait;
  end process;


end;
  



 
  