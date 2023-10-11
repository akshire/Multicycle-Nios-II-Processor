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
signal adder : integer;
begin
	process(clk,reset_n)
	begin
		if reset_n = '0' then
			address_save <= 0;
			addr <= x"00000000";
		elsif rising_edge(clk)then
			address_save <= address_save+adder;
			addr <= x"0000" & std_logic_vector(to_unsigned(address_save+adder,16));
		end if;
	end process;
	
	process(add_imm, imm, en,sel_imm,a,sel_a)
	begin
		if en = '1' then
			if add_imm = '1' then
				adder <= to_integer(signed(imm));
			elsif sel_imm = '1' then
				adder <= -address_save + to_integer((shift_left(signed(imm),2)));
			elsif sel_a = '1' then
				adder <= -address_save + to_integer(unsigned(a(15 downto 2) & "00"));
			else
				adder <= 4;
			end if;
		else
			adder <= 0;
		end if;
	end process;
end synth;
