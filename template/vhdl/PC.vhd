library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk     : in  std_logic;
        reset_n : in  std_logic;
        en      : in  std_logic;
        sel_a   : in  std_logic;
        sel_imm : in  std_logic;
        add_imm : in  std_logic;
        imm     : in  std_logic_vector(15 downto 0);
        a       : in  std_logic_vector(15 downto 0);
        addr    : out std_logic_vector(31 downto 0)
    );
end PC;

architecture synth of PC is
signal address_save : integer;
begin
	process(clk,reset_n, en)
	begin
		if reset_n = '0' then
			address_save <= 0;
		else
			if rising_edge(clk) and en = '1' then
				addr <= x"0000" & std_logic_vector(to_unsigned(address_save,16));
				address_save <= address_save + 4;
			end if;
			
		end if;
		
	end process;


end synth;
