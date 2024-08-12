module reg_EX_MEM #(
	parameter RESULTSRC_WIDTH = 2,
	parameter ALU_RESULT_WIDTH = 32,
	parameter REG_ADDR_WIDTH = 5,
	parameter PC_WIDTH = 32,
	parameter DATA_WIDTH = 32,
	parameter OPCODE_WIDTH = 7,
	parameter FUNCT7_WIDTH = 7,
	parameter FUNCT3_WIDTH = 3
)(
	input clk,
	input rst_n,

	input [OPCODE_WIDTH-1:0] opcode_E, 
	input [FUNCT7_WIDTH-1:0] funct7_E,
	input [FUNCT3_WIDTH-1:0] funct3_E,
	input RegWrite_E,
	input [RESULTSRC_WIDTH-1:0] ResultSrc_E,
	input MemWrite_E,
	input signed [ALU_RESULT_WIDTH-1:0] ALU_result_E,
	input [REG_ADDR_WIDTH-1:0] rd_E,
	input [PC_WIDTH-1:0] PCplus4_E,
	input [DATA_WIDTH-1:0] WriteData_E,
	input [1:0] write_type_E,

	output reg [OPCODE_WIDTH-1:0] opcode_M, 
	output reg [FUNCT7_WIDTH-1:0] funct7_M,
	output reg [FUNCT3_WIDTH-1:0] funct3_M,
	output reg RegWrite_M,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc_M,
	output reg MemWrite_M,
	output reg signed [ALU_RESULT_WIDTH-1:0] ALU_result_M,
	output reg [REG_ADDR_WIDTH-1:0] rd_M,
	output reg [PC_WIDTH-1:0] PCplus4_M,
	output reg [DATA_WIDTH-1:0] WriteData_M,
	output reg [1:0] write_type_M
);

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		opcode_M <= 0;
		funct7_M <= 0;
		funct3_M <= 0; 
		RegWrite_M <= 0;
		ResultSrc_M <= 0;
		MemWrite_M <= 0;
		ALU_result_M <= 0;
		rd_M <= 0;
		PCplus4_M <= 0;
		WriteData_M <= 0;
		write_type_M <= 0;
	end 
	else begin
		opcode_M <= opcode_E;
		funct7_M <= funct7_E;
		funct3_M <= funct3_E;
		RegWrite_M <= RegWrite_E;
		ResultSrc_M <= ResultSrc_E;
		MemWrite_M <= MemWrite_E;
		ALU_result_M <= ALU_result_E;
		rd_M <= rd_E;
		PCplus4_M <= PCplus4_E;
		WriteData_M <= WriteData_E;
		write_type_M <= write_type_E;
	end
end

endmodule 