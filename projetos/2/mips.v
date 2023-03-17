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
	
endmodule
