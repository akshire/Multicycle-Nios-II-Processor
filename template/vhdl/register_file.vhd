library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
    port(
        clk    : in  std_logic;
        aa     : in  std_logic_vector(4 downto 0);
        ab     : in  std_logic_vector(4 downto 0);
        aw     : in  std_logic_vector(4 downto 0);
        wren   : in  std_logic;
        wrdata : in  std_logic_vector(31 downto 0);
        a      : out std_logic_vector(31 downto 0);
        b      : out std_logic_vector(31 downto 0)
    );
end register_file;

architecture synth of register_file is
    type reg_type is array(0 to 31) of std_logic_vector(31 downto 0);
    signal reg: reg_type := (
        x"00000000", x"00000000",
        x"00000000", x"00000000",
        x"00000000", x"00000000",
        x"00000000", x"00000000",
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000",
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000",
        x"00000000", x"00000000", 
        x"00000000", x"00000000", 
        x"00000000", x"00000000"
        
    );
begin
    write :process(clk)
    begin
        if rising_edge(clk) and ((wren = '1') and (to_integer(unsigned(aw)) /= 0)) then
            reg(to_integer(unsigned(aw))) <= wrdata;
        end if;    
    end process;
    
    read_a : process(aa)
    begin
        a <= reg(to_integer(unsigned(aa)));
        
    end process;
    
    read_b : process(ab)
    begin
        b <= reg(to_integer(unsigned(ab)));
    end process;
    
        
    
    
end synth;
