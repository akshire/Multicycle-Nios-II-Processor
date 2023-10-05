library ieee;
use ieee.std_logic_1164.all;

entity ROM is
    port(
        clk     : in  std_logic;
        cs      : in  std_logic;
        read    : in  std_logic;
        address : in  std_logic_vector(9 downto 0);
        rddata  : out std_logic_vector(31 downto 0)
    );
end ROM;

architecture synth of ROM is
	component ROM_Block IS
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
	
	signal read_o : std_logic;
	signal rddata_o : std_logic_vector(31 DOWNTO 0);
	
	
begin
	save_process : process(clk)
    begin
        if(rising_edge(clk)) then
            read_o <= cs and read;
        end if;
    end process;
	

	file_search : ROM_Block
	port map(
		address=> address,
		clock => clk,
		q => rddata_o
	);
	
	rddata <= rddata_o when read_o = '1' else (others => 'Z');

		
end synth;
