module add_pc_imm #(
	parameter PC_WIDTH = 32,
	parameter IMM_WIDTH = 32
)(
	input [PC_WIDTH-1:0] pc,
	input [IMM_WIDTH-1:0] ImmExt,
	output [PC_WIDTH-1:0] pc_add_imm
);

assign pc_add_imm = pc + ImmExt;

endmodule