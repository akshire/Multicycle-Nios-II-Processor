library ieee;
use ieee.std_logic_1164.all;

entity extend is
    port(
        imm16  : in  std_logic_vector(15 downto 0);
        signed : in  std_logic;
        imm32  : out std_logic_vector(31 downto 0)
    );
end extend;

architecture synth of extend is

constant IMM16_ZERO : std_logic_vector(15 downto 0) := x"0000";
constant IMM16_ONE : std_logic_vector(15 downto 0) := x"ffff";
signal signed_imm16 : std_logic_vector(15 downto 0);
begin

process(imm16,signed)
		begin
			if signed = '0' then
				imm32 <= IMM16_ZERO & imm16;
			else
				if imm16(15) = '0' then
					imm32 <= IMM16_ZERO & imm16;
				else 
					imm32 <= IMM16_ONE & imm16;
				end if;
			end if;
		
	end process;
	
end synth;
