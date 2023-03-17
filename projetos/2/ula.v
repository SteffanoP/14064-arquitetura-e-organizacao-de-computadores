module ula(In1, In2, OP, result, Zero_flag);
	input wire [31:0] In1, In2;
	input wire [3:0] OP;
	output wire [31:0] result;
	output wire Zero_flag;

	reg [31:0] ula_result;
	assign result = ula_result;

	// TODO: Add Overflow and Carry flags
	always @(*) begin
		case (OP)
			4'b0000: ula_result = In1 & In2; //0000: AND
			4'b0001: ula_result = In1 | In2; //0001: OR
			4'b0010: ula_result = In1 + In2; //0010: ADD
			4'b0110: ula_result = In1 - In2; //0110: SUB
			4'b0111: ula_result = (In1 < In2) ? 32'd1 : 32'd0; //0111: SLT
			4'b1100: ula_result = ~ (In1 | In2); //1100: NOR
			4'b1101: ula_result = In1 ^ In2; //1101: XOR
			4'b1110: ula_result = In1 << In2; //1110: Shift left
			4'b1111: ula_result = In1 >> In2; //1111: Shift right
			default: ula_result = In1 + In2; //defaults to AND
		endcase
	end

	assign Zero_flag = (result == 0) ? 1'b1 : 1'b0;

endmodule
