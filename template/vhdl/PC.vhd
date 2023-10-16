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
signal current_address : std_logic_vector(15 downto 0);
signal next_address : std_logic_vector(15 downto 0);
begin
	process(clk,reset_n)
	
	begin
		if reset_n = '0' then
			current_address <= x"0000";
		elsif rising_edge(clk) then
		
			current_address <= next_address;
		end if;
		
	end process;
	
	process(add_imm, imm, en,sel_imm,a,sel_a,current_address)
	begin
		if en = '1' then
			if add_imm = '1' then
				next_address <= std_logic_vector(signed(current_address) + signed(imm));
			elsif sel_imm = '1' then
				next_address <= imm(13 downto 0) & "00";
			elsif sel_a = '1' then
				next_address <= a(15 downto 2) & "00";
			else
				next_address <= std_logic_vector(unsigned(current_address) + to_unsigned(4,16));
			end if;
		else
			next_address <= current_address;
		end if;
		
	end process;
	addr <=  x"0000" & current_address(15 downto 2) & "00";
end synth;
