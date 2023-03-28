`include "counter.v"
`include "i_mem.v"
`include "mux.v"
`include "pc.v"
`include "regfile.v"
`include "ula.v"
`include "ula_control.v"
`include "sign_extend.v"
`include "utils.v"

module mips(clock, reset, pc, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] pc, ula_result, data_mem;

	wire [1:0] ula_operation;
	// ULA_CONTROL MODULE
	ula_control mips_ula_control(ula_operation, instruction[5:0], OP);
	// ULA MODULE
	wire [31:0] In1, In2;
	wire [3:0] OP;
	wire ula_zero_flag;
	ula mips_ula(In1, In2, OP, ula_result, ula_zero_flag);
	
	// PC MODULE
	wire [31:0] nextPC; // conterá o próximo endereço (a atualização da soma)
	PC pc_check(pc, nextPC, clock);

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

  
	//Sign extend from 16 to 32 bits
	wire [31:0] sign_extend_to_mux;
	sign_extend mips_sign_extend(instruction[15:0], sign_extend_to_mux);

	//Somador para branching
	add32 branching(pc_increment, (sign_extend_to_mux << 2), add_branching_to_mux);
	wire [31:0] add_branching_to_mux;

	wire branch; //Saída do controle em caso de branching
	wire branch_sel; //Atribuição em caso de branching do PC para outra instrução
	assign branch_sel = branch & ula_zero_flag; //AND de branching
	// Atribuição da próxima instrução do Program Counter (PC)
	mux_32 pc_mux(pc_increment, add_branching_to_mux, branch_sel, pc);
endmodule