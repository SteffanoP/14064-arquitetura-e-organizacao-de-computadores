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
    output reg [1:0] BranchOp;
    output reg [2:0] ALUOp;

    always @(opcode) begin
        case (opcode)
            6'b000000: begin //sll, srl, sra, sllv, srlv, jr, add, sub, and, or, xor, nor, slt, sltu
                RegDst = 1'b1;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b010;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b1;
            end
            6'b001000: begin //addi
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b000;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b001010: begin //slti
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b011;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b001100: begin //andi
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b100;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b001101: begin //ori
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b101;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b001110: begin //xori
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b110;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b100011: begin //lw
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                ALUOp = 3'b000;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
            end
            6'b101011: begin //sw
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b000;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegWrite = 1'b0;
            end
            6'b000100: begin //beq
                RegDst = 1'b0;
                BranchOp = 2'b01;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b001;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
            6'b000101: begin //bne
                RegDst = 1'b0;
                BranchOp = 2'b10;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b001;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
            default: begin //does nothing :)
                RegDst = 1'b0;
                BranchOp = 2'b00;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                ALUOp = 3'b000;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
            end
        endcase
    end
    
endmodule