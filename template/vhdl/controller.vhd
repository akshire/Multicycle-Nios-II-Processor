library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port(
        clk        : in  std_logic;
        reset_n    : in  std_logic;
        -- instruction opcode
        op         : in  std_logic_vector(5 downto 0);
        opx        : in  std_logic_vector(5 downto 0);
        -- activates branch condition
        branch_op  : out std_logic;
        -- immediate value sign extention
        imm_signed : out std_logic;
        -- instruction register enable
        ir_en      : out std_logic;
        -- PC control signals
        pc_add_imm : out std_logic;
        pc_en      : out std_logic;
        pc_sel_a   : out std_logic;
        pc_sel_imm : out std_logic;
        -- register file enable
        rf_wren    : out std_logic;
        -- multiplexers selections
        sel_addr   : out std_logic;
        sel_b      : out std_logic;
        sel_mem    : out std_logic;
        sel_pc     : out std_logic;
        sel_ra     : out std_logic;
        sel_rC     : out std_logic;
        -- write memory output
        read       : out std_logic;
        write      : out std_logic;
        -- alu op
        op_alu     : out std_logic_vector(5 downto 0)
    );
end controller;

architecture synth of controller is
type states is (Fetch_1,Fetch_2,Decoder, R_OP, Store, Break, Load_1,Load_2,I_OP);
signal current_state, next_state : states;
signal op_o : std_logic_vector(5 downto 0);
signal opx_o : std_logic_vector(5 downto 0);
begin

	process(reset_n):
	begin
		current_state <= I_OP;
		next_state <= Fetch_1;
	end process;

	process(clk):
	begin
		if(rising_edge(clk)) then
			current_state <= next_state;
			case current_state is
				when Fetch_1 =>
					read <= '1';
					next_state <= Fetch_2;
				when Fetch_2 =>
				-- READ SET A 0 SUPPOSITION
					read <= '0';
					pc_en <= '1';
					ir_en <= '1';
					next_state <= Decoder;
				when Decoder =>
					case op is
						when x"17"=>
							next_state <= Load_1
						when x"3A" =>
							if (opx = x"34") then
								next_state <= Break;
							else 
								next_state <= R_OP;
							end if;
						when x"15" => next_state <= Store;
						when others =>
							next_state <= I_OP;
						
							
					
				when R_OP =>
					rf_wren <= '1';
					sel_b <= '1';
					sel_rC <= '1';
					op_alu <= opx_o;
					next_state <= Fetch_1;
				when Store =>
					next_state <= Fetch_1;
				when Break =>
					next_state <= Break;
				when Load_1 =>
					sel_addr <= '1';
					read <= '1';
					op_alu <= op_o;
					-- SET A 1 BY SUPPOSITION
					imm_signed <= '1';
					sel_addr <= '1';
					next_state <= Load_2;
				when Load_2 =>
					read <= '0';
					rf_wren <= '1';
					sel_mem <= '1';
					next_state <= Fetch_1;
				when I_OP =>
					op_alu <= op_o;
					next_state <= Fetch_1;
				when others =>
			end case;
		end if;
	end process;
	
	process(opx)
	begin
		case opx is
			when x"31" => opx_o <= "000000";
			when x"39" => opx_o <= "001000";
			when x"0e" => opx_o <= "100001";
			when x"16" => opx_o <= "100010";
			when x"1e" => opx_o <= "100011"; 
			when x"06" => opx_o <= "100000"; 
			when x"08" => opx_o <= "011001"; 
			when x"10" => opx_o <= "011010"; 
			when x"18" => opx_o <= "011011"; 
			when x"20" => opx_o <= "011100"; 
			when x"28" => opx_o <= "011101";
			when x"30" => opx_o <= "011110";
			when x"13" => opx_o <= "110010";
			when x"12" => opx_o <= "110010";
			when x"1b" => opx_o <= "110011";
			when x"1a" => opx_o <= "110011";
			when x"3b" => opx_o <= "110111";
			when x"3a" => opx_o <= "110111";
			when x"03" => opx_o <= "110000";
			when x"0b" => opx_o <= "110001";
			when x"02" => opx_o <= "110000";
			-- ICI ON SAIT PAS
			when x"1d" => opx_o <= "000000";
			when x"05" => opx_o <= "000000";
			when x"0d" => opx_o <= "000000";
			when others => opx_o <= "000000";
		
		opx_o <= "000" & opx(5 downto 3);
	end process;
	
	process(op)
	begin
		case op is 
			when x"04" => op_o <= "000000";
			when x"0c" => op_o <= "000000";
			when x"14" => op_o <= "100010";
			when x"1c" => op_o <= "100011";
			-- DON T KNOW IF ITS TYPO IN THE DOC 
			when x"08" => op_o <= "011001";
			when x"10" => op_o <= "01101";
			when x"18" => op_o <= "011011";
			when x"20" => op_o <= "011100";
			when x"28" => op_o <= "011101";
			when x"30" => op_o <= "011110";
			when x"07" => op_o <= "000000";
			when x"17" => op_o <= "000000";
			when x"05" => op_o <= "000000";
			when x"15" => op_o <= "000000";
			when x"06" => op_o <= "000000";
			when x"0e" => op_o <= "011001";
			when x"16" => op_o <= "011010";
			when x"1e" => op_o <= "011011";
			when x"26" => op_o <= "011100";
			when x"2e" => op_o <= "011101";
			when x"36" => op_o <= "011110";
			when others => op_o <= "00000";
			
			
		op_o <= "000" & op(5 downto 3);
	end process;
	
end synth;
