module main_decoder #(
	parameter RESULTSRC_WIDTH = 2,
	parameter OPCODE_WIDTH = 7,
	parameter IMM_SRC_WIDTH = 2,
	parameter ALU_OP_WIDTH = 2
)(
	input [OPCODE_WIDTH-1:0] opcode,
	output reg RegWrite,
	output reg [IMM_SRC_WIDTH-1:0] ImmSrc,
	output reg ALUSrc,
	output reg MemWrite,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc,
	output reg Branch,
	output reg Jump,
	output reg [ALU_OP_WIDTH-1:0] ALUOp
);
always @ (*) begin
	case(opcode)
		7'b0110011: begin // R-Type
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrc = 0;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b10;
			Jump = 0;
		end

		7'b 0010011: begin // I-Type
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrc = 1;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b01;
			Jump = 0;
		end

		7'b 0100011: begin // S-Type
			RegWrite = 0;
			ImmSrc = 2'b01;
			ALUSrc = 1;
			MemWrite = 1;
			Branch=0;
			ALUOp=2'b00;
			Jump = 0;
		end

		7'b 0000011: begin // L-Type
			RegWrite = 1;
			ImmSrc = 2'b01;
			ALUSrc = 1;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b00;
			// ResultSrc = 2'b10;
			ResultSrc = 2'b01;
			Jump = 0;
		end

		7'b 1100011: begin // B-Type
			RegWrite=0;
			ImmSrc=2'b10;
			ALUSrc=0;
			MemWrite=0;
			Branch=1;
			ALUOp=2'b11;
			Jump = 0;
		end

		7'b 1101111: begin // J-Type
			RegWrite = 1;
			ImmSrc = 2'b10;
			ALUSrc = 0;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b10; 
			// ResultSrc = 2'b00;
			ResultSrc = 2'b10;
			Jump = 1;
		end

		default: begin
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrc = 0;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b10;
			Jump = 0;
		end

	endcase
end
endmodule