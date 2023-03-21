module PC(PC, nextPC, clock);
	// Declaração de entradas e saída
	input wire [31:0] PC;
	output reg [31:0] nextPC;
	input clock;
	// Declaração de flag
	reg reset;

	// Inicializando reset e nextPC com 0
	initial begin
		reset = 0;
		nextPC = 32'b0;
	end

	// Atribuição síncrona. Se reset == 1, nextPC recebe o mesmo
	// valor que PC, caso contrário nextPC é setado em 0 e reset ´
	// tem o valor alterado
	always @(posedge clock) begin
		if(reset) begin
			nextPC = PC;
		end else begin
			nextPC = 32'b0;
			reset = 1;
		end
	end
endmodule