library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port(
        clk     : in  std_logic;
        cs      : in  std_logic;
        read    : in  std_logic;
        write   : in  std_logic;
        address : in  std_logic_vector(9 downto 0);
        wrdata  : in  std_logic_vector(31 downto 0);
        rddata  : out std_logic_vector(31 downto 0));
end RAM;

architecture synth of RAM is
type ram_type is array(0 to 1023) of std_logic_vector(31 downto 0);

	signal ram: ram_type;
    signal read_o: std_logic;
    signal address_o : std_logic_vector(9 downto 0);
    
begin
    
    save_process : process(clk)
    begin
        if(rising_edge(clk)) then
            read_o <= cs and read;
            address_o <= address;
        end if;
    end process;
    
	
    read_process : process (address_o, read_o)
    begin
        rddata <= (others => 'Z');
        if(read_o = '1') then
           rddata <= ram(to_integer(unsigned(address_o)));
        end if;
    end process;
    
	
    write_process : process(clk)
    begin
        if(rising_edge(clk)) then
            if( cs = '1' and write = '1' )then
             ram(to_integer(unsigned(address))) <= wrdata;
             end if;
        end if;
    end process;
end synth;