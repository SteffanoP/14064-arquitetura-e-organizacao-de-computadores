module jump (
    next_pc,
    address,
    new_pc
);
    input wire [3:0] next_pc;
    input wire [25:0] address;
    output wire [31:0] new_pc;

    assign new_pc = {next_pc, address, 2'b00};
endmodule