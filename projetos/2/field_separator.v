module Field_separator (instr, op_out, rs_out, rt_out, RegDst, rd_out);
    input wire [31:0] instr;
    input RegDst; // (selector) <= vem da Control
    output wire [5:0] op_out;
    output wire [4:0] rs_out, rt_out;
    output wire [4:0] rd_out;

    assign op_out = instr[31:26];
    assign rs_out = instr[25:21];
    assign rt_out = instr[20:16];
    assign rd_out = RegDst ? instr[15:11] : instr[20:16];

endmodule