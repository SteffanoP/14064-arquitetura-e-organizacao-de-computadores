module Adder(pc, pc_increment);
	// Declaração de entrada e saída
	input [31:0] pc;
	output [31:0] pc_increment;
	// Declaração do 4 para somar ao pc
	reg [31:0] four;

	// Inicialização do four com o número 4 em hexadecimal
	initial begin
		four = 32'h00000004;
	end

	// Atribuição da soma do pc
	assign pc_increment = four + pc;

endmodule

module add32 (in1,in2,out);
    input wire [31:0] in1, in2;
    output wire [31:0] out;

    assign out = in1 + in2;
    
endmodule