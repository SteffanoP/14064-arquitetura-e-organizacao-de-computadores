module regfile(ReadAddr1, ReadAddr2, ReadData1, ReadData2, Clock, WriteAddr, WriteData, RegWrite, Reset);

input [4:0] ReadAddr1, ReadAddr2, WriteAddr;
input [31:0] WriteData;
input Clock, RegWrite, Reset;

output [31:0] ReadData1, ReadData2;
reg [31:0] ReadData1, ReadData2;

reg [31:0] Reg[0:31];

integer i;

task rst;
    begin
       for(i = 0; i < 32; i = i+1)
			Reg[i] = 0;
    end
endtask

initial begin
	rst;
end

always @(posedge Clock) begin
	if(Reset)
		rst;
	else begin
		if(RegWrite == 1'b1)
		Reg[WriteAddr] = WriteData;
		else begin
			ReadData1 = Reg[ReadAddr1];
			ReadData2 = Reg[ReadAddr2];
		end
	end
end

endmodule