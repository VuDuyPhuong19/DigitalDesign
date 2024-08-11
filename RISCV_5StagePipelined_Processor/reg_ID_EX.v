module reg_ID_EX #(
	parameter RESULTSRC_WIDTH = 2,
	parameter ALUCONTROL_WIDTH = 4,
	parameter IMMSRC_WIDTH = 2,
	parameter REG_ADDR_WIDTH = 5,
	parameter REG_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter PC_WIDTH = 32
)(
	input clk,
	input rst_n,
	
	input Flush_E,
	input RegWrite_D,
   input [RESULTSRC_WIDTH-1:0] ResultSrc_D,
   input MemWrite_D,
   input Jump_D,
   input Branch_D,
   input [ALUCONTROL_WIDTH-1:0] ALUControl_D,
   input ALUSrc_D,
   input [REG_ADDR_WIDTH-1:0] rs1_D, 
	input [REG_ADDR_WIDTH-1:0] rs2_D,
	input [REG_ADDR_WIDTH-1:0] rd_D,
	input [REG_WIDTH-1:0] rd1_D, 
	input [REG_WIDTH-1:0] rd2_D,
	input [IMM_WIDTH-1:0] ImmExt_D,
	input [PC_WIDTH-1:0] PCplus4_D,
	input [PC_WIDTH-1:0] PC_D,

   output reg RegWrite_E,
   output reg [RESULTSRC_WIDTH-1:0] ResultSrc_E,
   output reg MemWrite_E,
   output reg Jump_E,
   output reg Branch_E,
   output reg [ALUCONTROL_WIDTH-1:0] ALUControl_E,
   output reg ALUSrc_E,
   output reg [REG_ADDR_WIDTH-1:0] rs1_E, 
	output reg [REG_ADDR_WIDTH-1:0] rs2_E,
	output reg [REG_ADDR_WIDTH-1:0] rd_E,
	output reg [REG_WIDTH-1:0] rd1_E, 
	output reg [REG_WIDTH-1:0] rd2_E,
	output reg [IMM_WIDTH-1:0] ImmExt_E,
	output reg [PC_WIDTH-1:0] PCplus4_E,
	output reg [PC_WIDTH-1:0] PC_E
);

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		RegWrite_E <= 0;
		ResultSrc_E <= 0;
		MemWrite_E <= 0;
		Jump_E <= 0;
		Branch_E <= 0;
		ALUControl_E <= 0;
		ALUSrc_E <= 0;
		rs1_E <= 0;
		rs2_E <= 0;
		rd_E <= 0;
		rd1_E <= 0;
		rd2_E <= 0;
		ImmExt_E <= 0;
		PCplus4_E <= 0;
		PC_E <= 0;
	end
	else begin
		if (!Flush_E) begin
			RegWrite_E <= RegWrite_D;
			ResultSrc_E <= ResultSrc_D;
			MemWrite_E <= MemWrite_D;
			Jump_E <= Jump_D;
			Branch_E <= Branch_D;
			ALUControl_E <= ALUControl_D;
			ALUSrc_E <= ALUSrc_D;
			rs1_E <= rs1_D;
			rs2_E <= rs2_D;
			rd_E <= rd_D;
			rd1_E <= rd1_D;
			rd2_E <= rd2_D;
			ImmExt_E <= ImmExt_D;
			PCplus4_E <= PCplus4_D;
			PC_E <= PC_D;
		end
		else begin
			RegWrite_E <= 0;
			ResultSrc_E <= 0;
			MemWrite_E <= 0;
			Jump_E <= 0;
			Branch_E <= 0;
			ALUControl_E <= 0;
			ALUSrc_E <= 0;
			rs1_E <= 0;
			rs2_E <= 0;
			rd_E <= 0;
			rd1_E <= 0;
			rd2_E <= 0;
			ImmExt_E <= 0;
			PCplus4_E <= 0;
			PC_E <= 0;
		end
	end
end

endmodule 