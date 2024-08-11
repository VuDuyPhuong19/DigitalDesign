module reg_EX_MEM #(
	parameter RESULTSRC_WIDTH = 2,
	parameter ALU_RESULT_WIDTH = 32,
	parameter REG_ADDR_WIDTH = 5,
	parameter PC_WIDTH = 32,
	parameter DATA_WIDTH = 32
)(
	input clk,
	input rst_n,

	input RegWrite_E,
   input [RESULTSRC_WIDTH-1:0] ResultSrc_E,
   input MemWrite_E,
	input signed [ALU_RESULT_WIDTH-1:0] ALU_result_E,
	input [REG_ADDR_WIDTH-1:0] rd_E,
	input [PC_WIDTH-1:0] PCplus4_E,
	input [DATA_WIDTH-1:0] WriteData_E,

	output reg RegWrite_M,
   output reg [RESULTSRC_WIDTH-1:0] ResultSrc_M,
   output reg MemWrite_M,
	output reg signed [ALU_RESULT_WIDTH-1:0] ALU_result_M,
	output reg [REG_ADDR_WIDTH-1:0] rd_M,
	output reg [PC_WIDTH-1:0] PCplus4_M,
	output reg [DATA_WIDTH-1:0] WriteData_M
);

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		RegWrite_M <= 0;
		ResultSrc_M <= 0;
		MemWrite_M <= 0;
		ALU_result_M <= 0;
		rd_M <= 0;
		PCplus4_M <= 0;
		WriteData_M <= 0;
	end 
	else begin
		RegWrite_M <= RegWrite_E;
		ResultSrc_M <= ResultSrc_E;
		MemWrite_M <= MemWrite_E;
		ALU_result_M <= ALU_result_E;
		rd_M <= rd_E;
		PCplus4_M <= PCplus4_E;
		WriteData_M <= WriteData_E;
	end
end

endmodule 