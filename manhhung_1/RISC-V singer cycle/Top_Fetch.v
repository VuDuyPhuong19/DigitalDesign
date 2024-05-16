module Top_Fetch(
	input wire clk,
	input wire rst_n,
	input wire [9:0] Sum,
	input wire [1:0] control_mux,
	output wire [31:0] Instruction
);
wire [9:0] address;
wire [9:0] next_address;
wire [9:0] add_normal;
Add_Fetch add1(
	.address(next_address),
	.add_normal(add_normal)
);
MUX_PETCH mux_1(
	.Sum(Sum),
	.add_normal(add_normal),
	.control(control_mux),
	.address(address)
);
PC pc_1(
	.clk(clk),
	.rst_n(rst_n),
	.address(address),
	.next_address(next_address),
);
Memory_instruction mem_ins(
	.Address(next_address),
	.reset(rst_n),
	.instruction(Instruction)
);
endmodule