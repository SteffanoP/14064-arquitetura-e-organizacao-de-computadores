module Mux_ireg(inst0, inst1, RegDst, inst_selected);
	input [4:0] inst0, inst1;
	input RegDst; // <= vem da Control
	output reg [4:0] inst_selected;

	always @ (inst0 or inst1 or RegDst) begin
		inst_selected = (RegDst) ? inst0 : inst1;	
	end

endmodule