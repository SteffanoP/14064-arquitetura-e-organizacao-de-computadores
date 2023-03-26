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

	// Clock current_clock(clock);
	PC pc_check(pc, nextPC, clock);

	wire [31:0] pc_increment;
	Counter pc_counter(nextPC, pc_increment); //talvez setar o 4 dentro da função seja melhor...

	// INSTRUCTION MEMORY MODULE
	wire [31:0] instruction;
	i_mem current_instruction(nextPC, instruction);
endmodule
