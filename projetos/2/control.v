module control (
    opcode,
    RegDst,
    BranchOp,
    MemRead,
    MemtoReg,
    ALUOp,
    MemWrite,
    ALUSrc,
    RegWrite
);
    input wire [5:0] opcode;
    output reg RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    output reg [1:0] ALUOp, BranchOp;

    always @(opcode) begin
        case (opcode)
            6'b000000: begin //sll, srl, sra, sllv, srlv, jr, add, sub, and, or, xor, nor, slt, sltu
                RegDst = 1'b1;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b10;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b1;
            end
            6'b001000: begin //addi
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b100011: begin //lw
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b101011: begin //sw
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b00;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b0;
            end
            6'b000100: begin //beq
                RegDst = 1'b0;
                BranchOp = 2'b01;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b01;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
            6'b000101: begin //bne
                RegDst = 1'b0;
                BranchOp = 2'b10;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b01;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
            default: begin //does nothing :)
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
        endcase
    end
    
endmodule