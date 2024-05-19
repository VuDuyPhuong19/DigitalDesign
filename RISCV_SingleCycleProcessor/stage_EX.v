module stage_EX #(
	parameter REG_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter ALUControl_WIDTH = 3,
	parameter ALU_RESULT_WIDTH = 32,
	parameter PC_WIDTH = 32
)(
	input [IMM_WIDTH-1:0] ImmExt,
	input [REG_WIDTH-1:0] data_rs1,
	input [REG_WIDTH-1:0] data_rs2,
	input [ALUControl_WIDTH-1:0] ALUControl,
	input [PC_WIDTH-1:0] pc,
	input ALUSrc,
	output zero,
	output [ALU_RESULT_WIDTH-1:0] ALU_result,
	output [PC_WIDTH-1:0] pc_add_imm
);

parameter OP_WIDTH = 32;
wire [OP_WIDTH-1:0] opB;

assign opB = ALUSrc ? ImmExt : data_rs2;

alu alu(.opA(data_rs1),
		.opB(opB),
		.ALUControl(ALUControl),
		.zero(zero),
		.ALU_result(ALU_result)
		);

add_pc_imm adder(.pc(pc),
				 .ImmExt(ImmExt),
				 .pc_add_imm(pc_add_imm)
				 );

endmodule