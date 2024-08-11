module reg_MEM_WB #(
	parameter RESULTSRC_WIDTH = 2,
	parameter REG_ADDR_WIDTH = 5,
	parameter ALU_RESULT_WIDTH = 32,
	parameter DATA_WIDTH = 32,
	parameter PC_WIDTH = 32
)(
	input clk,
	input rst_n,

	input RegWrite_M,
	input [RESULTSRC_WIDTH-1:0] ResultSrc_M,
	input [REG_ADDR_WIDTH-1:0] rd_M,
	input [ALU_RESULT_WIDTH-1:0] ALU_result_M,
	input [DATA_WIDTH-1:0] ReadData_M,
	input [PC_WIDTH-1:0] PCplus4_M,

	output reg RegWrite_W,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc_W,
	output reg [REG_ADDR_WIDTH-1:0] rd_W,
	output reg [ALU_RESULT_WIDTH-1:0] ALU_result_W,
	output reg [DATA_WIDTH-1:0] ReadData_W,
	output reg [PC_WIDTH-1:0] PCplus4_W
);

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		RegWrite_W <= 0;
		ResultSrc_W <= 0;
		rd_W <= 0;
		ALU_result_W <= 0;
		ReadData_W <= 0;
		PCplus4_W <= 0;
	end
	else begin
		RegWrite_W <= RegWrite_M;
		ResultSrc_W <= ResultSrc_M;
		rd_W <= rd_M;
		ALU_result_W <= ALU_result_M;
		ReadData_W <= ReadData_M;
		PCplus4_W <= PCplus4_M;
	end
end

endmodule 