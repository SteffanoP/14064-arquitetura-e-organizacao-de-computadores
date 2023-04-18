module mux_32 (in1, in2, sel, out);
    // Declaração de entradas e saídas
	input wire [31:0] in1, in2;
	input wire sel;
	output wire [31:0] out;

    //Determinação do multiplexador
	assign out = sel ? in1 : in2;
endmodule

module mux_32_4 (
	in1,
	in2,
	in3,
	in4,
	sel,
	out
);
	input wire [31:0] in1, in2, in3, in4;
	input wire [1:0] sel;
	output wire [31:0] out;

	assign out = sel[1] ? (sel[0] ? in4 : in3) : (sel[0] ? in2 : in1);
endmodule
// mux_32_4 pc_mux (pc_increment, add_branching_to_mux, jump_module_to_mux, jr_PC, PCSource, nextPC);

module mux_src(ALUsrc, ReadData2, SignExtended32, ALUin2);
	// Declaração das entradas e saídas
	input ALUsrc;
	input [31:0] ReadData2, SignExtended32;
	
	output reg [31:0] ALUin2;
	
	// Bloco que será executado a partir de todas as entradas
	always @(ALUsrc, ReadData2, SignExtended32) begin
		/*Casos possíveis para a flag de controle ALUsrc, onde 
		ela determina o valor que será passado para a saída*/
		case (ALUsrc)
			0: ALUin2 <= ReadData2;
			1: ALUin2 <= SignExtended32;
		endcase
	end
endmodule

module mux_5_4(inst0, inst1, inst2, inst3, RegDst, imem_mux_to_write_register);
	// Declaração das entradas e saída
	input [4:0] inst0, inst1, inst2, inst3;
	input [1:0] RegDst; // <= vem da Control
	output wire [4:0] imem_mux_to_write_register;

	// Determinação do multiplexador
	assign imem_mux_to_write_register = RegDst[1] ? (RegDst[0] ? inst3 : inst2) : (RegDst[0] ? inst1 : inst0);

endmodule