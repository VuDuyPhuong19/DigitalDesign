module Add_Fetch #(
    parameter PC_WIDTH = 32
)(
    input[PC_WIDTH-1:0] pc,
    output [PC_WIDTH-1:0] pc_add_1
);
assign pc_add_1 = pc + 1;
endmodule