module jr_control(ula_opcode, func, JR_control);

    //declarar entradas e saídas
    input wire [1:0] ula_opcode;
    input wire [3:0] func;
    output reg JR_control;

    always @(*) begin
        if ({ula_opcode, func} == 6'b001000) // Verifica se ula_opcode e func correspondem ao opcode da instrução jr (6'b001000)
		    begin
            JR_control = 1'b1; // Se sim, define JR_control como 1
			 end
        else
		    begin
            JR_control = 1'b0;  // Caso contrário, define JR_control como 0
			 end
    end

endmodule