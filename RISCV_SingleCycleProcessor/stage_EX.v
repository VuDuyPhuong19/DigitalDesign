module stage_EX #(
	parameter REG_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter ALUCONTROL_WIDTH = 4,
	parameter ALU_RESULT_WIDTH = 32,
	parameter PC_WIDTH = 32,
	parameter OP_WIDTH = 32
)(
	input [IMM_WIDTH-1:0] ImmExt,
	input [REG_WIDTH-1:0] data_rs1,
	input [REG_WIDTH-1:0] data_rs2,
	input [ALUCONTROL_WIDTH-1:0] ALUControl,
	input [PC_WIDTH-1:0] pc,
	input ALUSrc,
	output zero,
	output [ALU_RESULT_WIDTH-1:0] ALU_result,
	output [PC_WIDTH-1:0] pc_add_imm
);

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


module stage_EX_tb();

parameter REG_WIDTH = 32;
parameter IMM_WIDTH = 32;
parameter ALUCONTROL_WIDTH = 4;
parameter ALU_RESULT_WIDTH = 32;
parameter PC_WIDTH = 32;
parameter OP_WIDTH = 32;

reg [IMM_WIDTH-1:0] ImmExt;
reg [REG_WIDTH-1:0] data_rs1;
reg [REG_WIDTH-1:0] data_rs2;
reg [ALUCONTROL_WIDTH-1:0] ALUControl;
reg [PC_WIDTH-1:0] pc;
reg ALUSrc;
wire zero;
wire [ALU_RESULT_WIDTH-1:0] ALU_result;
wire [PC_WIDTH-1:0] pc_add_imm;

stage_EX uut(.ImmExt(ImmExt),
			 .data_rs1(data_rs1),
			 .data_rs2(data_rs2),
			 .ALUControl(ALUControl),
			 .pc(pc),
			 .ALUSrc(ALUSrc),
			 .zero(zero),
			 .ALU_result(ALU_result),
			 .pc_add_imm(pc_add_imm)
			 );

initial begin
	#3
	ImmExt = 5;
	data_rs1 = 6;
	data_rs2 = 6;
	ALUControl = 4'b0001;
	pc = 1;
	ALUSrc = 0;
	#100 $finish();
end

endmodule