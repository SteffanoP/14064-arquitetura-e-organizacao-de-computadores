`include "i_mem.v"
`include "pc.v"
`include "regfile.v"
`include "ula.v"
`include "sign_extend.v"
`include "d_mem.v"
`include "control/control.v"
`include "jump/jump.v"
`include "utils/utils.v"
`include "control/jr_control.v"

module mips(clock, reset, nextPC, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] nextPC, ula_result, data_mem;

	// CONTROL MODULE
	wire MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump, isJAL;
	wire [1:0] PCOp, RegDst;
	control mips_control (
		instruction[31:26],
		RegDst,
		PCOp,
		MemRead,
		MemtoReg,
		ula_operation,
		MemWrite,
		ALUSrc,
		RegWrite,
		Jump,
		isJAL
	);

	wire [2:0] ula_operation;

	// MÓDULO ULA_CONTROL
	ula_control mips_ula_control(ula_operation, instruction[5:0], OP);
	// MÓDULO ULA
	wire [31:0] regfile_mux_to_ula_In2;
	wire [3:0] OP;
	wire ula_zero_flag;
	ula mips_ula(ReadData1, regfile_mux_to_ula_In2, OP, instruction[10:6], ula_result, ula_zero_flag);
	
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

	wire [31:0] WriteData;
	mux_32 mux_32_d_mem(data_mem, ula_result, MemtoReg, WriteData);

	// MUX (i_mem e regfile)
	// 00 => RT (instrução tipo I)
	// 01 => RD (instrução tipo R)
	// 10 => 31 ($ra => para jal)
	wire [4:0] imem_mux_to_write_register;
	mux_5_4 imem_reg_mux(instruction[20:16], instruction[15:11], 5'b11111, ,RegDst, imem_mux_to_write_register);

	// MUX (Write Data)
	// 0 => Vem de D_Mem
	// 1 => Vem de JAL
	wire [31:0] to_write_data_mux_in2;
	wire [31:0] to_write_data;
	Adder jal (pc_increment, to_write_data_mux_in2);
	mux_32 write_data_mux(WriteData, to_write_data_mux_in2, isJAL, to_write_data);

	// MÓDULO REGFILE
	wire [31:0] ReadData1, ReadData2;
	regfile mips_regfile(
		instruction[25:21], 
		instruction[20:16], 
		ReadData1, 
		ReadData2, 
		clock, 
		imem_mux_to_write_register, 
		to_write_data, 
		RegWrite, 
		reset
	);

	// MUX (regfile e ula)
	mux_32 regfile_mux(ReadData2, sign_extend_to_mux, ALUSrc, regfile_mux_to_ula_In2);

	//Sign extend de 16 para 32 bits
	wire [31:0] sign_extend_to_mux;
	sign_extend mips_sign_extend(instruction[15:0], sign_extend_to_mux);

	//Somador para branching
	add32 branching(pc_increment, (sign_extend_to_mux << 2), add_branching_to_mux);
	wire [31:0] add_branching_to_mux;

	PCControl pc_control(PCOp, ula_zero_flag, PCSource);

	//Módulo de JUMP
	wire [31:0] jump_module_to_mux;
	jump mips_jump(pc_increment[31:28], instruction[25:0], jump_module_to_mux);

	//Módulo de JR
	wire [31:0] JR_control;
	jr_control mips_jr_control(pc_increment, instruction[25:21], JR_control);

	// Atribuição da próxima instrução do Program Counter (PC)
	wire [1:0] PCSource; //Saída do módulo em caso de branching
	mux_32_4 pc_mux (pc_increment, add_branching_to_mux, jump_module_to_mux, , PCSource, nextPC);
endmodule