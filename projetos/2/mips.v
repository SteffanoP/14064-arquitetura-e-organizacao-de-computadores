`include "adder.v"
`include "i_mem.v"
`include "mux.v"
`include "pc.v"
`include "regfile.v"
`include "control.v"
`include "ula.v"
`include "ula_control.v"
`include "sign_extend.v"
`include "utils.v"
`include "d_mem.v"
`include "branch.v"

module mips(clock, reset, nextPC, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] nextPC, ula_result, data_mem;

	// CONTROL MODULE
	wire RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	wire [1:0] BranchOp;
	control mips_control (
		instruction[31:26],
		RegDst,
		BranchOp,
		MemRead,
		MemtoReg,
		ula_operation,
		MemWrite,
		ALUSrc,
		RegWrite
	);

	wire [2:0] ula_operation;

	// MÓDULO ULA_CONTROL
	ula_control mips_ula_control(ula_operation, instruction[5:0], OP);
	// MÓDULO ULA
	wire [31:0] In2;
	wire [3:0] OP;
	wire ula_zero_flag;
	ula mips_ula(ReadData1, In2, OP, ula_result, ula_zero_flag);
	
	// MÓDULO PC
	wire [31:0] pc;
	PC pc_check(nextPC, pc, clock);

	wire [31:0] pc_increment; // Representará o resultado da soma do valor do PC
	Adder pc_counter(pc, pc_increment); // Módulo para atualizar o valor do PC

	// MÓDULO INSTRUÇÃO DE MEMÓRIA
	wire [31:0] instruction;
	i_mem current_instruction(pc, instruction);

	// MÓDULO D_MEM
	d_mem mips_d_mem(ula_result, ReadData2, data_mem, MemWrite, MemRead);

	wire WriteData;
	mux_32 mux_32_d_mem(data_mem, ula_result, MemtoReg, WriteData);

	// MUX (i_mem e regfile)
	mux_4 imem_reg_mux(instruction[20:16], instruction[15:11], RegDst, imem_mux_to_write_register);

	// MÓDULO REGFILE
	wire [31:0] ReadData1, ReadData2;
	regfile mips_regfile(instruction[25:21], instruction[20:16], ReadData1, ReadData2, clock, imem_mux_to_write_register, WriteData, RegWrite, reset);

	// MUX (regfile e ula)
	mux_src mips_mux_src(ALUSrc, ReadData2, sign_extend_to_mux, In2);

	//Sign extend de 16 para 32 bits
	wire [31:0] sign_extend_to_mux;
	sign_extend mips_sign_extend(instruction[15:0], sign_extend_to_mux);

	//Somador para branching
	add32 branching(pc_increment, (sign_extend_to_mux << 2), add_branching_to_mux);
	wire [31:0] add_branching_to_mux;

	branch beq_bne_selector(BranchOp, ula_zero_flag, Branch);
	wire Branch; //Saída do módulo em caso de branching

	// Atribuição da próxima instrução do Program Counter (PC)
	mux_32 pc_mux(pc_increment, add_branching_to_mux, Branch, nextPC);
endmodule