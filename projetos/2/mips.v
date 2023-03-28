module mips(clock, reset, pc, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] pc, ula_result, data_mem;

	// ULA MODULE
	reg [31:0] In1, In2;
	reg [3:0] OP;
	wire Zero_flag;
	ula mips_ula(In1, In2, OP, ula_result);
	
	// PC MODULE
	wire [31:0] nextPC; // conterá o próximo endereço (a atualização da soma)
	PC pc_check(PC, nextPC, clock);

	wire [31:0] pc_increment; // Representará o resultado da soma do valor do PC
	Counter pc_counter(nextPC, pc_increment); // Módulo para atualizar o valor do PC

	// INSTRUCTION MEMORY MODULE
	wire [31:0] instruction;
	i_mem current_instruction(nextPC, instruction);

	// FIELD SEPARATOR MUX (instruction)
	wire RegDst;
	wire [5:0] op_out;
	wire [4:0] rs_out, rt_out, rd_out;
	Field_separator mux_sep_instr(instruction, op_out, rs_out, rt_out, RegDst, rd_out);

	// MUX (i_mem and regfile)
	//Mux_ireg mux(instruction[20:16], instruction[15:11], RegDst, inst_selected);

endmodule