module mips(in, out);
	input wire in;
	output wire out;
	
	assign out = !in;

	// ULA MODULE
	reg [31:0] In1, In2;
	reg [3:0] OP;
	wire [31:0] result;
	wire Zero_flag;
	ula mips_ula(In1, In2, OP, result);
	
	// PC MODULE
	wire clock;
	wire [31:0] PC; // contém o endereço atual
	wire [31:0] nextPC; // conterá o próximo endereço (a atualização da soma)

	Clock current_clock(clock);
	PC pc_check(PC, nextPC, clock);

	wire [31:0] pc_increment;
	Counter pc_counter(nextPC, pc_increment); //talvez setar o 4 dentro da função seja melhor...

	// INSTRUCTION MEMORY MODULE
	wire [31:0] instruction;
	i_mem current_instruction(nexPC, instruction);
endmodule
