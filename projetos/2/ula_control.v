module ula_control(ula_operation, func, operation);
    input wire [1:0] ula_operation;
    input wire [5:0] func;
    output reg [3:0] operation;

    always @(*) begin
        case (ula_operation)
            2'b00: operation <= 4'b0010; //LW, SW => ADD
            2'b01: operation <= 4'b0110; //Branch => SUB
            2'b10: //Instruções do tipo R
                case (func) //TODO: Adicionar funções de shift
                    6'b100000: operation <= 4'b0010; //add
                    6'b100010: operation <= 4'b0110; //sub
                    6'b100100: operation <= 4'b0000; //and
                    6'b100101: operation <= 4'b0001; //or
                    6'b100110: operation <= 4'b1101; //xor
                    6'b100111: operation <= 4'b1100; //nor
                    6'b101010: operation <= 4'b0111; //SLT
                    default: operation <= 4'b0000; //defaults to AND
                endcase
        endcase 
    end

endmodule