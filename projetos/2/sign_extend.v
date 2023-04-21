module sign_extend (in,out);
    input wire [15:0] in;
    output wire [31:0] out;

    assign out = $signed(in);
endmodule