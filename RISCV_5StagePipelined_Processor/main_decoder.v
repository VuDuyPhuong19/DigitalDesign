module main_decoder #(
	parameter RESULTSRC_WIDTH = 2,
	parameter OPCODE_WIDTH = 7,
	parameter IMM_SRC_WIDTH = 2,
	parameter ALU_OP_WIDTH = 2,
	parameter FUNCT3_WIDTH = 3
)(
	input [OPCODE_WIDTH-1:0] opcode,
	input [FUNCT3_WIDTH-1:0] funct3,
	output reg RegWrite,
	output reg [IMM_SRC_WIDTH-1:0] ImmSrc,
	output reg [1:0] ALUSrcA,
	output reg ALUSrcB,
	output reg MemWrite,
	output reg [RESULTSRC_WIDTH-1:0] ResultSrc,
	output reg Branch,
	output reg Jump,
	output reg [ALU_OP_WIDTH-1:0] ALUOp,
	output reg PCJalSrc_D, // jalr
	output reg [1:0] write_type_D
);
always @ (*) begin
	case(opcode)
		7'b0110011: begin // R-Type
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrcB = 0;
			ALUSrcA = 2'b01;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b10;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b 0010011: begin // I-Type
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrcB = 1;
			ALUSrcA = 2'b01;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b01;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b 0100011: begin // S-Type
			RegWrite = 0;
			ImmSrc = 2'b01;
			ALUSrcB = 1;
			ALUSrcA = 2'b01;
			MemWrite = 1;
			Branch=0;
			ALUOp=2'b00;
			Jump = 0;
			PCJalSrc_D = 0;
			write_type_D = (funct3 == 3'b000) ? 2'b00 : ((funct3 == 3'b001) ? 2'b01 : ((funct3 == 3'b010) ? 2'b10 : 2'b11));
		end

		7'b 0000011: begin // L-Type
			RegWrite = 1;
			ImmSrc = 2'b01;
			ALUSrcB = 1;
			ALUSrcA = 2'b01;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b00;
			// ResultSrc = 2'b10;
			ResultSrc = 2'b01;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b 1100011: begin // B-Type
			RegWrite=0;
			ImmSrc=2'b10;
			ALUSrcB=0;
			ALUSrcA = 2'b01;
			MemWrite=0;
			Branch=1;
			ALUOp=2'b11;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b 1101111: begin // J-Type
			RegWrite = 1;
			ImmSrc = 2'b10;
			ALUSrcB = 0;
			ALUSrcA = 2'b01;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b01; 
			// ResultSrc = 2'b00;
			ResultSrc = 2'b10;
			Jump = 1;
			PCJalSrc_D = 0;
		end

		7'b1100111: begin // JALR
			RegWrite = 1;
			ImmSrc = 2'b10;
			ALUSrcB = 1;
			ALUSrcA = 2'b01;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b01; 
			// ResultSrc = 2'b00;
			ResultSrc = 2'b10;
			Jump = 1;
			PCJalSrc_D = 1;
		end

		7'b0110111: begin // lui
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrcB = 1;
			ALUSrcA = 2'b00;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b01;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b0010111: begin // auipc
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrcB = 1;
			ALUSrcA = 2'b10;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b01;
			Jump = 0;
			PCJalSrc_D = 0;			
		end

		default: begin
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrcB = 0;
			ALUSrcA = 0;
			MemWrite = 0;
			// ResultSrc = 2'b01;
			ResultSrc = 2'b00;
			Branch = 0;
			ALUOp = 2'b10;
			Jump = 0;
			PCJalSrc_D = 0;
		end

	endcase
end
endmodule