module stage_ID #(
	parameter INST_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter NUM_REG = 32,
	parameter REG_ADDR_WIDTH = $clog2(NUM_REG),
	parameter REG_WIDTH = 32,
	parameter IMMSRC_WIDTH = 2,
	parameter RESULTSRC_WIDTH = 2,
	parameter ALU_CONTROL_WIDTH = 3
)(
	input clk, 
	input rst_n,
	input [INST_WIDTH-1:0] Instruction,
	// input [REG_ADDR_WIDTH-1:0] addr_rs1, addr_rs2, addr_rd,
	input [REG_WIDTH-1:0] data_rd,
	input zero,
	output [REG_WIDTH-1:0] data_rs1, data_rs2,
	output [IMM_WIDTH-1:0] ImmExt,
    output [IMMSRC_WIDTH-1:0] ImmSrc,
	output ALUSrc,
	output MemWrite,
	output [RESULTSRC_WIDTH-1:0] ResultSrc,
    output [ALU_CONTROL_WIDTH-1:0] ALUControl,
    output PCSrc
);

parameter OPCODE_WIDTH = 7;
parameter FUNCT7_WIDTH = 7;
parameter FUNCT3_WIDTH = 3;

wire [OPCODE_WIDTH-1:0] opcode;
wire [FUNCT7_WIDTH-1:0] funct7;
wire [FUNCT3_WIDTH-1:0] funct3;

wire [REG_ADDR_WIDTH-1:0] addr_rs1;
wire [REG_ADDR_WIDTH-1:0] addr_rs2;
wire [REG_ADDR_WIDTH-1:0] addr_rd;

wire RegWrite;

assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign addr_rs1 = Instruction[19:15];
assign addr_rs2 = Instruction[24:20];
assign addr_rd = Instruction[11:7];

ImmGen imm_gen(.Instruction(Instruction),
			   .ImmExt(ImmExt));

Registers regs(.clk(clk),
			  .rst_n(rst_n),
			  .RegWrite(RegWrite),
			  .addr_rs1(addr_rs1),
			  .addr_rs2(addr_rs2),
			  .addr_rd(addr_rd),
			  .data_rd(data_rd),
			  .data_rs1(data_rs1),
			  .data_rs2(data_rs2));

control_unit control_unit(.opcode(opcode),
						  .funct7(funct7),
						  .funct3(funct3),
						  .zero(zero),
						  .RegWrite(RegWrite),
						  .ImmSrc(ImmSrc),
						  .ALUSrc(ALUSrc),
						  .MemWrite(MemWrite),
						  .ResultSrc(ResultSrc),
						  .ALUControl(ALUControl),
						  .PCSrc(PCSrc));

endmodule

module stage_ID_tb();

parameter INST_WIDTH = 32;
parameter IMM_WIDTH = 32;
parameter NUM_REG = 32;
parameter REG_ADDR_WIDTH = $clog2(NUM_REG);
parameter REG_WIDTH = 32;
parameter RESULTSRC_WIDTH = 2;

reg clk;
reg rst_n;
reg [INST_WIDTH-1:0] Instruction;
// reg [REG_ADDR_WIDTH-1:0] addr_rs1, addr_rs2, addr_rd;
reg [REG_WIDTH-1:0] data_rd;
reg zero;

wire [REG_WIDTH-1:0] data_rs1, data_rs2;
wire [IMM_WIDTH-1:0] ImmExt;
wire [1:0] ImmSrc;
wire ALUSrc;
wire MemWrite;
wire [RESULTSRC_WIDTH-1:0] ResultSrc;
wire [2:0] ALUControl;
wire PCSrc;

stage_ID uut(.clk(clk),
			 .rst_n(rst_n),
			 .Instruction(Instruction),
			 .addr_rs1(addr_rs1),
			 .addr_rs2(addr_rs2),
			 .addr_rd(addr_rd),
			 .zero(zero),
			 .data_rs1(data_rs1),
			 .data_rs2(data_rs2),
			 .ImmExt(ImmExt),
			 .ImmSrc(ImmSrc),
			 .ALUSrc(ALUSrc),
			 .MemWrite(MemWrite),
			 .ResultSrc(ResultSrc),
			 .ALUControl(ALUControl),
			 .PCSrc(PCSrc));

integer i;
initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 0;
	#3 rst_n = 1;
	Instruction	= 32'b00000000001100010000000010110011;
	// addr_rs1 = 5'b00010;
	// addr_rs2 = 5'b00011;
	// addr_rd = 5'b00001;
	data_rd = 32'd12;
	zero = 0;
	#1000 $finish();
end

endmodule