module mux_32 (in1, in2, sel, out);
    // Declaração de entradas e saídas
	input wire [31:0] in1, in2;
	input wire sel;
	output wire [31:0] out;

    //Determinação do multiplexador
	assign out = sel ? in2 : in1;
endmodule

module mux_5(inst0, inst1, RegDst, imem_mux_to_write_register);
	// Declaração das entradas e saída
	input [4:0] inst0, inst1;
	input RegDst; // <= vem da Control
	output wire [4:0] imem_mux_to_write_register;

	// Determinação do multiplexador
	assign imem_mux_to_write_register = (RegDst) ? inst1 : inst0;

endmodule