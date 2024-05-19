module stage_WB #(
	parameter RESULTSRC_WIDTH = 2,
	parameter DATA_WIDTH = 32,
	parameter ALU_RESULT_WIDTH = 32,
	parameter WB_RESULT_WIDTH = 32,
	parameter PC_WIDTH = 32
)(
	input [RESULTSRC_WIDTH-1:0] ResultSrc,
	input [DATA_WIDTH-1:0] read_data,
	input [ALU_RESULT_WIDTH-1:0] ALU_result,
	input [PC_WIDTH-1:0] pc_add_1,
	output [WB_RESULT_WIDTH-1:0] wb_result
);

assign wb_result = (ResultSrc == 2'b00) ? pc_add_1 : ((ResultSrc == 2'b01) ? ALU_result : ((ResultSrc == 2'b10) ? read_data : 32'b0));

endmodule