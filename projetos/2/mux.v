module mux_32 (in1, in2, sel, out);
    // Declaração de entradas e saídas
	input wire [31:0] in1, in2;
	input wire sel;
	output wire [31:0] out;

    //Determinação do multiplexador
	assign out = sel ? in1 : in2;
endmodule

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

module mux_4(inst0, inst1, RegDst, inst_selected);
	// Declaração das entradas e saída
	input [4:0] inst0, inst1;
	input RegDst; // <= vem da Control
	output reg [4:0] inst_selected;

	// Determinação do multiplexador
	always @ (inst0 or inst1 or RegDst) begin
		inst_selected = (RegDst) ? inst0 : inst1;	
	end

endmodule