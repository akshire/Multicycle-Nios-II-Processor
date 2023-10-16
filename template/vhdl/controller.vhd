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

type states is (Fetch_1,Fetch_2,Decoder, R_OP, Store, Break, Load_1,Load_2,I_OP, Branch, Call, Callr, Jmp, Jmpi, UI_OP, RI_OP);
signal current_state: states := Fetch_1;
signal next_state : states:=Fetch_2;

begin
	process(clk)
	begin
		if reset_n = '0' then
			current_state <= Fetch_1;
		else
			if(rising_edge(clk)) then
			current_state <= next_state;
			end if;
		end if;
	end process;

	process(current_state)
	begin
		case current_state is
			when Fetch_1 =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '1';
				next_state  <= Fetch_2;
			when Fetch_2 =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '1';
				pc_add_imm  <= '0';
				pc_en       <= '1';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Decoder;
			when Decoder =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				case op is
				
					when "111010" =>
						case opx is
							when "110100" => next_state <= Break;
							when "011101" => next_state <= Callr;
							when "001101" => next_state <= Jmp;
							when "000101" => next_state <= Jmp;
							when "010010" => next_state <= RI_OP;
							when "011010" => next_state <= RI_OP;
							when "111010" => next_state <= RI_OP;
							when "000010" => next_state <= RI_OP;
							when others => next_state <= R_OP;
						end case;
					when "010111" => next_state <= Load_1;
					when "010101" => next_state <= Store;
					when "000110" => next_state <= Branch;
					when "001110" => next_state <= Branch;
					when "010110" => next_state <= Branch;
					when "011110" => next_state <= Branch;
					when "100110" => next_state <= Branch;
					when "101110" => next_state <= Branch;
					when "110110" => next_state <= Branch;
					when "000000" => next_state <= Call;
					when "000001" => next_state <= Jmpi;
					when "001100" => next_state <= UI_OP;
					when "010100" => next_state <= UI_OP;
					when "011100" => next_state <= UI_OP;
					when "101000" => next_state <= UI_OP;
					when "110000" => next_state <= UI_OP;
		
					when others   => next_state <= I_OP;
					end case;
			when R_OP =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '1';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '1';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Store =>
				branch_op   <= '0';
				imm_signed  <= '1';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '1';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '1';
				read        <= '0';
				next_state  <= Fetch_1;
			when Break =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Break;
			when Load_1 =>
				branch_op   <= '0';
				imm_signed  <= '1';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '1';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '1';
				next_state  <= Load_2;
			when Load_2 =>
				branch_op   <= '0';
				imm_signed  <= '1';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '1';
				sel_addr    <= '1';
				sel_b       <= '0';
				sel_mem     <= '1';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when I_OP =>
				branch_op   <= '0';
				imm_signed  <= '1';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Branch => 
				branch_op   <= '1';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '1';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '1';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Call =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '1';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '1';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '1';
				sel_ra      <= '1';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Callr =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '1';
				pc_sel_a    <= '1';
				pc_sel_imm  <= '0';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '1';
				sel_ra      <= '1';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Jmp =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '1';
				pc_sel_a    <= '1';
				pc_sel_imm  <= '0';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when Jmpi =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '1';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '1';
				rf_wren     <= '0';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when UI_OP =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '1';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '0';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
			when RI_OP =>
				branch_op   <= '0';
				imm_signed  <= '0';
				ir_en       <= '0';
				pc_add_imm  <= '0';
				pc_en       <= '0';
				pc_sel_a    <= '0';
				pc_sel_imm  <= '0';
				rf_wren     <= '1';
				sel_addr    <= '0';
				sel_b       <= '0';
				sel_mem     <= '0';
				sel_pc      <= '0';
				sel_ra      <= '0';
				sel_rC      <= '1';
				write       <= '0';
				read        <= '0';
				next_state  <= Fetch_1;
				
		end case;
	end process;
	process(opx, op)
	begin
		if(op = "111010") then
			case (opx) is
			when "110001" => op_alu <= "000000";
			when "111001" => op_alu <= "001000";
			when "001110" => op_alu <= "100001";
			when "010110" => op_alu <= "100010";
			when "011110" => op_alu <= "100011"; 
			when "000110" => op_alu <= "100000"; 
			when "001000" => op_alu <= "011001"; 
			when "010000" => op_alu <= "011010"; 
			when "011000" => op_alu <= "011011"; 
			when "100000" => op_alu <= "011100"; 
			when "101000" => op_alu <= "011101";
			when "110000" => op_alu <= "011110";
			when "010011" => op_alu <= "110010";
			when "010010" => op_alu <= "110010";
			when "011011" => op_alu <= "110011";
			when "011010" => op_alu <= "110011";
			when "111011" => op_alu <= "110111";
			when "111010" => op_alu <= "110111";
			when "000011" => op_alu <= "110000";
			when "001011" => op_alu <= "110001";
			when "000010" => op_alu <= "110000";
			-- ICI ON SAIT PAS
			when "011101" => op_alu <= "000000";
			when "000101" => op_alu <= "000000";
			when "001101" => op_alu <= "000000";
			when others   => 
		end case;
			
		else
			case (op) is 
			when "000100" => op_alu <= "000000";
			when "001100" => op_alu <= "100001";
			when "010100" => op_alu <= "100010";
			when "011100" => op_alu <= "100011";
			-- DON T KNOW IF ITS TYPO IN THE DOC 
			when "001000" => op_alu <= "011001";
			when "010000" => op_alu <= "011010";
			when "011000" => op_alu <= "011011";
			when "100000" => op_alu <= "011100";
			when "101000" => op_alu <= "011101";
			when "110000" => op_alu <= "011110";
			when "000111" => op_alu <= "000000";
			when "010111" => op_alu <= "000000";
			when "000101" => op_alu <= "000000";
			when "010101" => op_alu <= "000000";
			when "000110" => op_alu <= "011100";
			when "001110" => op_alu <= "011001";
			when "010110" => op_alu <= "011010";
			when "011110" => op_alu <= "011011";
			when "100110" => op_alu <= "011100";
			when "101110" => op_alu <= "011101";
			when "110110" => op_alu <= "011110";
			when others   => op_alu <= "000000";
		end case;
		end if;
	end process;
end synth;
