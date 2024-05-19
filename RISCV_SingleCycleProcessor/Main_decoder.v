module Main_decoder #(
	parameter RESULTSRC_WIDTH = 2
)(
	input [6:0] opcode,
	output reg RegWrite,
	output reg [1:0] ImmSrc,
	output reg ALUSrc,
	output reg MemWrite,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc,
	output reg Branch,
	output reg [1:0] ALUOp
);
always @ (*) begin
	case(opcode)
		7'b0110011: begin // R-Type
			RegWrite = 1;
			ImmSrc = 0;
			ALUSrc = 0;
			MemWrite = 0;
			ResultSrc = 2'b01;
			Branch = 0;
			ALUOp = 10;
		end
		7'b 0010011: begin // I-Type
			RegWrite = 1;
			ImmSrc = 0;
			ALUSrc = 1;
			MemWrite = 0;
			ResultSrc = 2'b01;
			Branch = 0;
			ALUOp = 01;
		end

		// 7'b 0000011:
		// 7'b 0100011:
		// 7'b 1100011:
		// 7'b 1101111:
		// 7'b 0110111:
		// 7'b 0010111:
		// 7'b 1110011: 
	endcase
end
endmodule