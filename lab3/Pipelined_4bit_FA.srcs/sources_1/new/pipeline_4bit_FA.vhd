library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pipeline_4bit_FA is
    port(
        a, b : in std_logic_vector(3 downto 0);
        cin, clk, rst : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end pipeline_4bit_FA;

architecture Structural of pipeline_4bit_FA is
    component reg 
        port (
            D : in STD_LOGIC;
            CLK : in STD_LOGIC;
            RSTn : in STD_LOGIC;
            Q : out STD_LOGIC
        );
    end component;

    component Pipelined_Full_Adder 
        port (
            c : in STD_LOGIC;
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            sum : out STD_LOGIC;
            carry_out : out STD_LOGIC
        );
    end component;

    signal tmp_a0, tmp_b0, tmp_s3 : std_logic;
    signal tmp_a1, tmp_b1, tmp_s2 : std_logic_vector(1 downto 0);
    signal tmp_a2, tmp_b2, tmp_s1 : std_logic_vector(2 downto 0);
    signal tmp_a3, tmp_b3, tmp_s0 : std_logic_vector(3 downto 0);
    signal tmp_cout : std_logic_vector(3 downto 0);
    signal tmp_cin : std_logic_vector(3 downto 0);

begin

    FA_0 : Pipelined_Full_Adder port map(a => tmp_a0, b => tmp_b0, c => tmp_cin(0), sum => tmp_s0(0), carry_out => tmp_cout(0));
    FA_1 : Pipelined_Full_Adder port map(a => tmp_a1(1), b => tmp_b1(1), c => tmp_cin(1), sum => tmp_s1(0), carry_out => tmp_cout(1));
    FA_2 : Pipelined_Full_Adder port map(a => tmp_a2(2), b => tmp_b2(2), c => tmp_cin(2), sum => tmp_s2(0), carry_out => tmp_cout(2));
    FA_3 : Pipelined_Full_Adder port map(a => tmp_a3(3), b => tmp_b3(3), c => tmp_cin(3), sum => tmp_s3, carry_out => tmp_cout(3));

    -- 1 delay tmp_a0
    reg_a0 : reg port map(D => a(0), CLK => clk, Q => tmp_a0, RSTn => rst);
    -- 2 delay tmp_a1
    reg_a1_0 : reg port map(D => a(1), CLK => clk, Q => tmp_a1(0), RSTn => rst);
    reg_a1_1 : reg port map(D => tmp_a1(0), CLK => clk, Q => tmp_a1(1), RSTn => rst);
    -- 3 delay tmp_a2
    reg_a2_0 : reg port map(D => a(2), CLK => clk, Q => tmp_a2(0), RSTn => rst);
    reg_a2_1 : reg port map(D => tmp_a2(0), CLK => clk, Q => tmp_a2(1), RSTn => rst);
    reg_a2_2 : reg port map(D => tmp_a2(1), CLK => clk, Q => tmp_a2(2), RSTn => rst);
    -- 4 delay tmp_a3
    reg_a3_0 : reg port map(D => a(3), CLK => clk, Q => tmp_a3(0), RSTn => rst);
    reg_a3_1 : reg port map(D => tmp_a3(0), CLK => clk, Q => tmp_a3(1), RSTn => rst);
    reg_a3_2 : reg port map(D => tmp_a3(1), CLK => clk, Q => tmp_a3(2), RSTn => rst);
    reg_a3_3 : reg port map(D => tmp_a3(2), CLK => clk, Q => tmp_a3(3), RSTn => rst);

    -- 1 delay tmp_b0
    reg_b0 : reg port map(D => b(0), CLK => clk, Q => tmp_b0, RSTn => rst);
    -- 2 delay tmp_b1
    reg_b1_0 : reg port map(D => b(1), CLK => clk, Q => tmp_b1(0), RSTn => rst);
    reg_b1_1 : reg port map(D => tmp_b1(0), CLK => clk, Q => tmp_b1(1), RSTn => rst);
    -- 3 delay tmp_b2
    reg_b2_0 : reg port map(D => b(2), CLK => clk, Q => tmp_b2(0), RSTn => rst);
    reg_b2_1 : reg port map(D => tmp_b2(0), CLK => clk, Q => tmp_b2(1), RSTn => rst);
    reg_b2_2 : reg port map(D => tmp_b2(1), CLK => clk, Q => tmp_b2(2), RSTn => rst);
    -- 4 delay tmp_b3
    reg_b3_0 : reg port map(D => b(3), CLK => clk, Q => tmp_b3(0), RSTn => rst);
    reg_b3_1 : reg port map(D => tmp_b3(0), CLK => clk, Q => tmp_b3(1), RSTn => rst);
    reg_b3_2 : reg port map(D => tmp_b3(1), CLK => clk, Q => tmp_b3(2), RSTn => rst);
    reg_b3_3 : reg port map(D => tmp_b3(2), CLK => clk, Q => tmp_b3(3), RSTn => rst);

    --1 delay for tmp_s3
    reg_s3 : reg port map(D => tmp_s3, CLK => clk, Q => sum(3), RSTn => rst);
    -- 2 delays for tmp_s2
    reg_s2_0 : reg port map(D => tmp_s2(0), CLK => clk, Q => tmp_s2(1), RSTn => rst);
    reg_s2_1 : reg port map(D => tmp_s2(1), CLK => clk, Q => sum(2), RSTn => rst);
    -- 3 delays for tmp_s1
    reg_s1_0 : reg port map(D => tmp_s1(0), CLK => clk, Q => tmp_s1(1), RSTn => rst);
    reg_s1_1 : reg port map(D => tmp_s1(1), CLK => clk, Q => tmp_s1(2), RSTn => rst);
    reg_s1_2 : reg port map(D => tmp_s1(2), CLK => clk, Q => sum(1), RSTn => rst);
    -- 4 delays for tmp_s0
    reg_s0_0 : reg port map(D => tmp_s0(0), CLK => clk, Q => tmp_s0(1), RSTn => rst);
    reg_s0_1 : reg port map(D => tmp_s0(1), CLK => clk, Q => tmp_s0(2), RSTn => rst);
    reg_s0_2 : reg port map(D => tmp_s0(2), CLK => clk, Q => tmp_s0(3), RSTn => rst);
    reg_s0_3 : reg port map(D => tmp_s0(3), CLK => clk, Q => sum(0), RSTn => rst);

    -- 1 delay for cin
    reg_c0 : reg port map(D => cin, CLK => clk, Q => tmp_cin(0), RSTn => rst);
    -- 1 delay for cout0
    reg_c1 : reg port map(D => tmp_cout(0), CLK => clk, Q => tmp_cin(1), RSTn => rst);
    -- 1 delay for cout1
    reg_c2 : reg port map(D => tmp_cout(1), CLK => clk, Q => tmp_cin(2), RSTn => rst);
    -- 1 delay for cout2
    reg_c3 : reg port map(D => tmp_cout(2), CLK => clk, Q => tmp_cin(3), RSTn => rst);
    -- 1 delay for cout3
    reg_c4 : reg port map(D => tmp_cout(3), CLK => clk, Q => cout, RSTn => rst);
   

end Structural;
