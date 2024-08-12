module reg_MEM_WB #(
	parameter RESULTSRC_WIDTH = 2,
	parameter REG_ADDR_WIDTH = 5,
	parameter ALU_RESULT_WIDTH = 32,
	parameter DATA_WIDTH = 32,
	parameter PC_WIDTH = 32,
	parameter OPCODE_WIDTH = 7,
	parameter FUNCT3_WIDTH = 3
)(
	input clk,
	input rst_n,

	input [OPCODE_WIDTH-1:0] opcode_M, 
	input [FUNCT3_WIDTH-1:0] funct3_M,
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
		if (opcode_M == 7'b0000011) begin
			case (funct3_M)
				3'b000: ReadData_W <= {{24{ReadData_M[7]}}, ReadData_M[7:0]}; 	// LB
				3'b001: ReadData_W <= {{16{ReadData_M[15]}}, ReadData_M[15:0]}; // LH
				3'b010: ReadData_W <= ReadData_M; 								// LW
				3'b100: ReadData_W <= {24'b0, ReadData_M[7:0]}; 				// LBU
				3'b101: ReadData_W <= {16'b0, ReadData_M[15:0]}; 				// LHU
				default: ReadData_W <= ReadData_M;
			endcase			
		end
		else begin
			ReadData_W <= ReadData_M;
		end
		RegWrite_W <= RegWrite_M;
		ResultSrc_W <= ResultSrc_M;
		rd_W <= rd_M;
		ALU_result_W <= ALU_result_M;
		PCplus4_W <= PCplus4_M;
	end
end

endmodule 