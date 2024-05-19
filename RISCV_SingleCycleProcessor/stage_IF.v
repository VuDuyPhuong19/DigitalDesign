module stage_IF #(
	parameter PC_WIDTH = 32,
	parameter INST_WIDTH = 32
)(
	input clk,
	input rst_n,
	input [PC_WIDTH-1:0] pc_add_imm,
	input PCSrc,
	output [PC_WIDTH-1:0] next_pc,
	output [INST_WIDTH-1:0] Instruction
);

wire [PC_WIDTH-1:0] pc;
wire [PC_WIDTH-1:0] pc_add_1;

Add_Fetch add1(
	.pc(next_pc),
	.pc_add_1(pc_add_1)
);
mux_fetch mux_1(
	.pc_add_imm(pc_add_imm),
	.pc_add_1(pc_add_1),
	.control(PCSrc),
	.pc(pc)
);
PC pc_1(
	.clk(clk),
	.rst_n(rst_n),
	.pc(pc),
	.next_pc(next_pc)
);
Memory_instruction mem_ins(
	.Address(next_pc),
	.instruction(Instruction)
);
endmodule