module branch (
    BranchOp,
    ZeroFlag,
    Branch
);
    input wire [1:0] BranchOp;
    input wire ZeroFlag;
    output wire Branch;

    assign Branch = (BranchOp == 2'b00) ? 1'b0 : (BranchOp == 1'b01 ? ZeroFlag : !ZeroFlag);
endmodule