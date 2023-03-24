module regfile(ReadAddr1, ReadAddr2, ReadData1, ReadData2, Clock, WriteAddr, WriteData, RegWrite, Reset);

input [4:0] ReadAddr1, ReadAddr2, WriteAddr;
input [31:0] WriteData;
input Clock, RegWrite, Reset;

output [31:0] ReadData1, ReadData2;

reg [31:0] Reg[0:31];

assign ReadData1 = Reg[ReadAddr1];
assign ReadData2 = Reg[ReadAddr2];

always @(posedge Clock or posedge Reset) begin
	if(Reset) begin
		Reg[0] <= 16'b0;  
		Reg[1] <= 16'b0;  
		Reg[2] <= 16'b0;  
		Reg[3] <= 16'b0;  
		Reg[4] <= 16'b0;  
		Reg[5] <= 16'b0;  
		Reg[6] <= 16'b0;  
		Reg[7] <= 16'b0;
		Reg[8] <= 16'b0;  
		Reg[9] <= 16'b0;  
		Reg[10] <= 16'b0;  
		Reg[11] <= 16'b0;  
		Reg[12] <= 16'b0;  
		Reg[13] <= 16'b0;  
		Reg[14] <= 16'b0;  
		Reg[15] <= 16'b0;
		Reg[16] <= 16'b0;  
		Reg[17] <= 16'b0;  
		Reg[18] <= 16'b0;  
		Reg[19] <= 16'b0;  
		Reg[20] <= 16'b0;  
		Reg[21] <= 16'b0;  
		Reg[22] <= 16'b0;  
		Reg[23] <= 16'b0;
		Reg[24] <= 16'b0;  
		Reg[25] <= 16'b0;  
		Reg[26] <= 16'b0;  
		Reg[27] <= 16'b0;  
		Reg[28] <= 16'b0;  
		Reg[29] <= 16'b0;  
		Reg[30] <= 16'b0;  
		Reg[31] <= 16'b0;
	end	
	else begin
		if(RegWrite == 1'b1) Reg[WriteAddr] = WriteData;
	end	
end
endmodule