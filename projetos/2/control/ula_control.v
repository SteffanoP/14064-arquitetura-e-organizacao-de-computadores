module ula_control(ula_operation, func, operation);
    input wire [3:0] ula_operation;
    input wire [5:0] func;
    output reg [3:0] operation;

    always @(*) begin
        case (ula_operation)
            4'b0000: operation <= 4'b0010; //LW, SW => ADD
            4'b0001: operation <= 4'b0110; //Branch => SUB
            4'b0010: //Instruções do tipo R
                case (func) //TODO: Adicionar funções de shift
                    6'b000100: operation <= 4'b1110; //SLLV
                    6'b000110: operation <= 4'b1111; //SRLV
                    6'b000111: operation <= 4'b1010; //SRAV
                    6'b000011: operation <= 4'b0100; //SRA
                    6'b000010: operation <= 4'b0101; //SRL
                    6'b000000: operation <= 4'b0011; //SLL
                    6'b100000: operation <= 4'b0010; //add
                    6'b100010: operation <= 4'b0110; //sub
                    6'b100100: operation <= 4'b0000; //and
                    6'b100101: operation <= 4'b0001; //or
                    6'b100110: operation <= 4'b1101; //xor
                    6'b100111: operation <= 4'b1100; //nor
                    6'b101010: operation <= 4'b0111; //SLT
                    6'b101011: operation <= 4'b0111; //SLTU
                    default: operation <= 4'b0000; //defaults to AND
                endcase
            4'b0011: operation <= 4'b0111; //slti
            4'b1000: operation <= 4'b1000; //sltiu
            4'b0100: operation <= 4'b0000; //andi
            4'b0101: operation <= 4'b0001; //ori
            4'b0110: operation <= 4'b1101; //xori
            4'b0111: operation <= 4'b1011; //lui
            default: operation <= 4'b0000; //defaults to AND
        endcase 
    end

endmodule