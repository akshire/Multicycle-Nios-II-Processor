library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port(
        address : in  std_logic_vector(15 downto 0);
        cs_LEDS : out std_logic;
        cs_RAM  : out std_logic;
        cs_ROM  : out std_logic;
		cs_buttons : out std_logic
    );
end decoder;

architecture synth of decoder is
    CONSTANT ROM_LB : std_logic_vector(15 downto 0) := x"0000"; -- to_integer(unsigned(x"0"));
    CONSTANT ROM_HB : std_logic_vector(15 downto 0) := x"0ffc"; --to_integer(unsigned(x"0ffc"));
    CONSTANT RAM_LB : std_logic_vector(15 downto 0) := x"1000"; --to_integer(unsigned(x"1000"));
    CONSTANT RAM_HB : std_logic_vector(15 downto 0) := x"1ffc"; --to_integer(unsigned(x"1ffc"));
    CONSTANT LED_LB : std_logic_vector(15 downto 0) := x"2000"; --to_integer(unsigned(x"2000"));
    CONSTANT LED_HB : std_logic_vector(15 downto 0) := x"200c"; --to_integer(unsigned(x"200c"));
	
	CONSTANT BUTTONS_LB : std_logic_vector(15 downto 0) := x"2030"; --to_integer(unsigned(x"200c"));
    CONSTANT BUTTONS_HB : std_logic_vector(15 downto 0) := x"2034"; --to_integer(unsigned(x"200c"));

    CONSTANT NOTHING_LB : std_logic_vector(15 downto 0) := x"2035"; 
    CONSTANT NOTHING_HB : std_logic_vector(15 downto 0) := x"fffc";
    
    
    
begin
    
    
    process(address)
    begin
        if address >= ROM_LB and ROM_HB >= address then
            cs_LEDS <= '0';
            cs_RAM <= '0';
            cs_ROM <= '1';
			cs_buttons <= '0';
        elsif address >= RAM_LB and RAM_LB >= address then
            cs_LEDS <= '0';
            cs_RAM <= '1';
            cs_ROM <= '0';
			cs_buttons <= '0';
        elsif address >= LED_LB and LED_HB >= address then 
            cs_LEDS <= '1';
            cs_RAM <= '0';
            cs_ROM <= '0';
			cs_buttons <= '0';
		elsif address >= BUTTONS_LB and BUTTONS_HB >= address then 
			cs_buttons <= '1';
			cs_LEDS <= '0';
            cs_RAM <= '0';
            cs_ROM <= '0';
        elsif address >= NOTHING_LB and NOTHING_HB >= address then
            cs_LEDS <= '0';
            cs_RAM <= '0';
            cs_ROM <= '0';
			cs_buttons <= '0';
		
        end if;
        
    end process;
    
end synth;
