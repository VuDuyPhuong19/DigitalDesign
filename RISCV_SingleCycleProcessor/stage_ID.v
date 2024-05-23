module stage_ID #(
	parameter INST_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter NUM_REG = 32,
	parameter REG_ADDR_WIDTH = $clog2(NUM_REG),
	parameter REG_WIDTH = 32,
	parameter IMMSRC_WIDTH = 2,
	parameter RESULTSRC_WIDTH = 2,
	parameter ALUCONTROL_WIDTH = 4,
	parameter OPCODE_WIDTH = 7,
	parameter FUNCT7_WIDTH = 7,
	parameter FUNCT3_WIDTH = 3,
	parameter OPCODE_R_TYPE = 7'b0110011,
	parameter OPCODE_I_TYPE = 7'b0010011,
	parameter OPCODE_S_TYPE = 7'b0100011,
	parameter OPCODE_L_TYPE = 7'b0000011,
	parameter OPCODE_B_TYPE = 7'b1100011,
	parameter OPCODE_J_TYPE = 7'b1101111
)(
	input clk, 
	input rst_n,
	input [INST_WIDTH-1:0] Instruction,
	input [REG_WIDTH-1:0] data_rd,
	input zero,
	output [REG_WIDTH-1:0] data_rs1, data_rs2,
	output [IMM_WIDTH-1:0] ImmExt,
    output [IMMSRC_WIDTH-1:0] ImmSrc,
	output ALUSrc,
	output MemWrite,
	output [RESULTSRC_WIDTH-1:0] ResultSrc,
    output [ALUCONTROL_WIDTH-1:0] ALUControl,
    output PCSrc
);

wire [OPCODE_WIDTH-1:0] opcode;
reg [FUNCT7_WIDTH-1:0] funct7;
reg [FUNCT3_WIDTH-1:0] funct3;

reg [REG_ADDR_WIDTH-1:0] addr_rs1;
reg [REG_ADDR_WIDTH-1:0] addr_rs2;
reg [REG_ADDR_WIDTH-1:0] addr_rd;

wire RegWrite;

assign opcode = Instruction[6:0];

always @ (*) begin
	case(opcode)
		OPCODE_R_TYPE: begin
			funct3 = Instruction[14:12];
			funct7 = Instruction[31:25];
			addr_rs1 = Instruction[19:15];
			addr_rs2 = Instruction[24:20];
			addr_rd = Instruction[11:7];
		end
		OPCODE_I_TYPE: begin
			addr_rs1 = Instruction[19:15];
			addr_rd = Instruction[11:7];
			funct3 = Instruction[14:12];
		end
		OPCODE_L_TYPE: begin
			addr_rs1 = Instruction[19:15];
			addr_rd = Instruction[11:7];
			funct3 = Instruction[14:12];
		end
		OPCODE_S_TYPE: begin
			funct3 = Instruction[14:12];
			addr_rs1 = Instruction[19:15];
			addr_rs2 = Instruction[24:20];
		end
		OPCODE_B_TYPE: begin
			funct3 = Instruction[14:12];
			addr_rs1 = Instruction[19:15];
			addr_rs2 = Instruction[24:20];
		end
		OPCODE_J_TYPE: begin
			addr_rd = Instruction[11:7];
		end
		default: begin
			funct3 = 0;
			funct7 = 0;
			addr_rs1 = 0;
			addr_rs2 = 0;
			addr_rd = 0;
		end
	endcase
end

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
wire [3:0] ALUControl;
wire PCSrc;

stage_ID uut(.clk(clk),
			 .rst_n(rst_n),
			 .Instruction(Instruction),
			 .data_rd(data_rd),
			 // .addr_rs1(addr_rs1),
			 // .addr_rs2(addr_rs2),
			 // .addr_rd(addr_rd),
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
	Instruction	= 32'b0000000_00110_00101_000_01000_1100011; // beq x5, x6, 4
	data_rd = 32'd12;
	zero = 0;
	#1000 $finish();
end

endmodule