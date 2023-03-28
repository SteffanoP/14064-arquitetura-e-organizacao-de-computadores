`include "counter.v"
`include "i_mem.v"
`include "mux_src.v"
`include "pc.v"
`include "regfile.v"
`include "ula.v"
`include "ula_control.v"
`include "sign_extend.v"

module mips(clock, reset, pc, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] pc, ula_result, data_mem;

	wire [1:0] ula_operation;
	// ULA_CONTROL MODULE
	ula_control mips_ula_control(ula_operation, instruction[5:0], OP);
	// ULA MODULE
	wire [31:0] In1, In2;
	wire [3:0] OP;
	wire Zero_flag;
	ula mips_ula(In1, In2, OP, ula_result);
	
	// PC MODULE
	wire [31:0] nextPC; // conterá o próximo endereço (a atualização da soma)
	PC pc_check(pc, nextPC, clock);

	// TODO: Implement pc_increment on MUX that will select the next PC
	// wire [31:0] pc_increment; // Representará o resultado da soma do valor do PC
	Counter pc_counter(nextPC, pc); // Módulo para atualizar o valor do PC

	// INSTRUCTION MEMORY MODULE
	wire [31:0] instruction;
	i_mem current_instruction(nextPC, instruction);

	wire [31:0] sign_extend_to_mux;
	sign_extend mips_sign_extend (instruction[15:0], sign_extend_to_mux);
endmodule
