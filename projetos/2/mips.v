`include "counter.v"
`include "i_mem.v"
`include "mux.v"
`include "pc.v"
`include "regfile.v"
`include "ula.v"
`include "ula_control.v"
`include "sign_extend.v"
`include "utils.v"
`include "d_mem.v"

module mips(clock, reset, pc, ula_result, data_mem);
	input wire clock, reset;
	output wire [31:0] pc, ula_result, data_mem;

	wire [1:0] ula_operation;
	// MÓDULO ULA_CONTROL
	ula_control mips_ula_control(ula_operation, instruction[5:0], OP);
	// MÓDULO ULA
	wire [31:0] In1, In2;
	wire [3:0] OP;
	wire ula_zero_flag;
	ula mips_ula(In1, In2, OP, ula_result, ula_zero_flag);
	
	// MÓDULO PC
	wire [31:0] nextPC; // conterá o próximo endereço (a atualização da soma)
	PC pc_check(pc, nextPC, clock);

	wire [31:0] pc_increment; // Representará o resultado da soma do valor do PC
	Counter pc_counter(nextPC, pc_increment); // Módulo para atualizar o valor do PC

	// MÓDULO INSTRUÇÃO DE MEMÓRIA
	wire [31:0] instruction;
	i_mem current_instruction(nextPC, instruction);

	// D_MEM MODULE
	wire memWrite; //vem do controle
	wire memRead;  //vem do controle
	d_mem mips_d_mem(ula_result, ReadData2, data_mem, memWrite, memRead);

	wire memToReg; //vem do controle
	wire WriteData;
	mux_32 mux_32_d_mem(data_mem, ula_result, memToReg, WriteData);

	// MUX (i_mem e regfile)
	wire RegDst; // Vem da Control
	mux_4 imem_reg_mux(instruction[20:16], instruction[15:11], RegDst, imem_mux_to_write_register);

	// MÓDULO REGFILE
	wire [31:0] ReadData1, ReadData2;
	wire RegWrite; // Vem da Control
	regfile mips_regfile(instruction[25:21], instruction[20:16], ReadData1, ReadData2, clock, imem_mux_to_write_register, WriteData, RegWrite, reset);

	// MUX (regfile e ula)
	wire ALUsrc; // Vem da Control
	mux_src mips_mux_src(ALUsrc, ReadData2, sign_extend_to_mux, In2);

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