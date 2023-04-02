module Adder(nextPC, pc_increment);
	// Declaração de entrada e saída
	input [31:0] nextPC;
	output [31:0] pc_increment;
	// Declaração do 4 para somar ao nextPC
	reg [31:0] four;

	// Inicialização do four com o número 4 em hexadecimal
	initial begin
		four = 32'h00000004;
	end

	// Atribuição da soma do PC
	assign pc_increment = four + nextPC;

endmodule