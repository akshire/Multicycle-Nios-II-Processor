library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
    port(
        a        : in  std_logic_vector(31 downto 0);
        b        : in  std_logic_vector(31 downto 0);
        sub_mode : in  std_logic;
        carry    : out std_logic;
        zero     : out std_logic;
        r        : out std_logic_vector(31 downto 0)
    );
end add_sub;

architecture synth of add_sub is
signal current_b,current_a,current_r : std_logic_vector(32 downto 0);

begin
    zero <= '1' when current_r(31 downto 0) = (31 downto 0 => '0') else '0';

    current_a <= '0' & a;
    current_b <=  ('0' & not b) when sub_mode = '1' else ('0' & b);

    current_r <= std_logic_vector(unsigned(current_a) + unsigned(current_b)) when sub_mode = '0'
                else std_logic_vector(unsigned(current_a) + unsigned(current_b) + 1);

    r <= current_r(31 downto 0);
    carry <= current_r(32);
end synth;
