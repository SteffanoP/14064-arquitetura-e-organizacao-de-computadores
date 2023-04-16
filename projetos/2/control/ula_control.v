module ula_control(ula_operation, func, operation);
    input wire [2:0] ula_operation;
    input wire [5:0] func;
    output reg [3:0] operation;

    always @(*) begin
        case (ula_operation)
            3'b000: operation <= 4'b0010; //LW, SW => ADD
            3'b001: operation <= 4'b0110; //Branch => SUB
            3'b010: //Instruções do tipo R
                case (func) //TODO: Adicionar funções de shift
                    6'b000100: operation <= 4'b1110; //SLLV
                    6'b000110: operation <= 4'b1111; //SRLV
                    6'b000111: operation <= 4'b1111; //SRAV
                    6'b100000: operation <= 4'b0010; //add
                    6'b100010: operation <= 4'b0110; //sub
                    6'b100100: operation <= 4'b0000; //and
                    6'b100101: operation <= 4'b0001; //or
                    6'b100110: operation <= 4'b1101; //xor
                    6'b100111: operation <= 4'b1100; //nor
                    6'b101010: operation <= 4'b0111; //SLT
                    6'b101011: operation <= 4'b0111; //SLTU
                    6'b001000: operation <= 4'b0011; //jr
                    default: operation <= 4'b0000; //defaults to AND
                endcase
            3'b011: operation <= 4'b0111; //slti
            3'b100: operation <= 4'b0000; //andi
            3'b101: operation <= 4'b0001; //ori
            3'b110: operation <= 4'b1101; //xori
            3'b111: operation <= 4'b1011; //lui
        endcase 
    end

endmodule