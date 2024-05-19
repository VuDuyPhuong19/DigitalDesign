module mux_fetch #(
    parameter PC_WIDTH = 32
)(
    input [PC_WIDTH-1:0] pc_add_imm,
    input [PC_WIDTH-1:0] pc_add_1,
    input control,
    output [PC_WIDTH-1:0] pc
);
assign pc = (~control) ? pc_add_1 : pc_add_imm;

endmodule