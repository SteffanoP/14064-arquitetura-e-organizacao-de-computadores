module sign_extend (in,out);
    input wire [15:0] in;
    output wire [31:0] out;

    assign out = (in[15] == 1'b1) ? {16'hffff, in} : {16'h0000, in};
endmodule