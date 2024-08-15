module reg_ID_EX #(
	parameter RESULTSRC_WIDTH = 2,
	parameter ALUCONTROL_WIDTH = 4,
	parameter IMMSRC_WIDTH = 2,
	parameter REG_ADDR_WIDTH = 5,
	parameter REG_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter PC_WIDTH = 32,
	parameter OPCODE_WIDTH = 7,
	parameter FUNCT7_WIDTH = 7,
	parameter FUNCT3_WIDTH = 3
)(
	input clk,
	input rst_n,

	input [OPCODE_WIDTH-1:0] opcode_D, 
	input [FUNCT7_WIDTH-1:0] funct7_D,
	input [FUNCT3_WIDTH-1:0] funct3_D,
	input Flush_E,
	input RegWrite_D,
	input [RESULTSRC_WIDTH-1:0] ResultSrc_D,
	input MemWrite_D,
	input Jump_D,
	input Branch_D,
	input [ALUCONTROL_WIDTH-1:0] ALUControl_D,
	input ALUSrcB_D,
	input [1:0] ALUSrcA_D,
	input [REG_ADDR_WIDTH-1:0] rs1_D, 
	input [REG_ADDR_WIDTH-1:0] rs2_D,
	input [REG_ADDR_WIDTH-1:0] rd_D,
	input [REG_WIDTH-1:0] rd1_D, 
	input [REG_WIDTH-1:0] rd2_D,
	input [IMM_WIDTH-1:0] ImmExt_D,
	input [PC_WIDTH-1:0] PCplus4_D,
	input [PC_WIDTH-1:0] PC_D,
	input PCJalSrc_D,
	input [1:0] write_type_D,

	output reg [OPCODE_WIDTH-1:0] opcode_E, 
	output reg [FUNCT7_WIDTH-1:0] funct7_E,
	output reg [FUNCT3_WIDTH-1:0] funct3_E,
	output reg RegWrite_E,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc_E,
	output reg MemWrite_E,
	output reg Jump_E,
	output reg Branch_E,
	output reg [ALUCONTROL_WIDTH-1:0] ALUControl_E,
	output reg ALUSrcB_E,
	output reg [1:0] ALUSrcA_E,
	output reg [REG_ADDR_WIDTH-1:0] rs1_E, 
	output reg [REG_ADDR_WIDTH-1:0] rs2_E,
	output reg [REG_ADDR_WIDTH-1:0] rd_E,
	output reg [REG_WIDTH-1:0] rd1_E, 
	output reg [REG_WIDTH-1:0] rd2_E,
	output reg [IMM_WIDTH-1:0] ImmExt_E,
	output reg [PC_WIDTH-1:0] PCplus4_E,
	output reg [PC_WIDTH-1:0] PC_E,
	output reg PCJalSrc_E,
	output reg [1:0] write_type_E
);

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		opcode_E <= 0;
		funct7_E <= 0;
		funct3_E <= 0; 
		RegWrite_E <= 0;
		ResultSrc_E <= 0;
		MemWrite_E <= 0;
		Jump_E <= 0;
		Branch_E <= 0;
		ALUControl_E <= 0;
		ALUSrcB_E <= 0;
		ALUSrcA_E <= 0;
		rs1_E <= 0;
		rs2_E <= 0;
		rd_E <= 0;
		rd1_E <= 0;
		rd2_E <= 0;
		ImmExt_E <= 0;
		PCplus4_E <= 0;
		PC_E <= 0;
		PCJalSrc_E <= 0;
		write_type_E <= 0;
	end
	else begin
		if (!Flush_E) begin
			opcode_E <= opcode_D;
			funct7_E <= funct7_D;
			funct3_E <= funct3_D; 
			RegWrite_E <= RegWrite_D;
			ResultSrc_E <= ResultSrc_D;
			MemWrite_E <= MemWrite_D;
			Jump_E <= Jump_D;
			Branch_E <= Branch_D;
			ALUControl_E <= ALUControl_D;
			ALUSrcB_E <= ALUSrcB_D;
			ALUSrcA_E <= ALUSrcA_D;
			rs1_E <= rs1_D;
			rs2_E <= rs2_D;
			rd_E <= rd_D;
			rd1_E <= rd1_D;
			rd2_E <= rd2_D;
			ImmExt_E <= ImmExt_D;
			PCplus4_E <= PCplus4_D;
			PC_E <= PC_D;
			PCJalSrc_E <= PCJalSrc_D;
			write_type_E <= write_type_D;
		end
		else begin
			opcode_E <= 0;
			funct7_E <= 0;
			funct3_E <= 0; 
			RegWrite_E <= 0;
			ResultSrc_E <= 0;
			MemWrite_E <= 0;
			Jump_E <= 0;
			Branch_E <= 0;
			ALUControl_E <= 0;
			ALUSrcB_E <= 0;
			ALUSrcA_E <= 0;
			rs1_E <= 0;
			rs2_E <= 0;
			rd_E <= 0;
			rd1_E <= 0;
			rd2_E <= 0;
			ImmExt_E <= 0;
			PCplus4_E <= 0;
			PC_E <= 0;
			PCJalSrc_E <= 0;
			write_type_E <= 0;
		end
	end
end

endmodule 