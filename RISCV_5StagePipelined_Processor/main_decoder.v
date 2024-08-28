module main_decoder #(
	parameter RESULTSRC_WIDTH = 2,
	parameter OPCODE_WIDTH = 7,
	parameter IMM_SRC_WIDTH = 2,
	parameter ALU_OP_WIDTH = 2,
	parameter FUNCT3_WIDTH = 3,
	parameter FUNCT7_WIDTH = 7
)(
	input [OPCODE_WIDTH-1:0] opcode,
	input [FUNCT3_WIDTH-1:0] funct3,
	input [FUNCT7_WIDTH-1:0] funct7,
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
	output reg [1:0] write_type_D,
	output reg start_mult_D,
	output reg start_div_D,
	output reg [1:0] mult_func_D,
	output reg [1:0] div_func_D,
	output reg ALUResultSrc_D // 1: mult/div result, 0: ALU result
	// output reg [1:0] calc_result_src_D
);
always @ (*) begin
	RegWrite = 0;
	ImmSrc = 0;
	ALUSrcB = 0;
	ALUSrcA = 0;
	MemWrite = 0;
	ResultSrc = 0;
	Branch = 0;
	ALUOp = 2'b01;
	Jump = 0;
	PCJalSrc_D = 0;	
	write_type_D = 0;
	ALUResultSrc_D = 0;
	start_mult_D = 0;
	start_div_D = 0;
	mult_func_D = 2'b00;
	div_func_D = 2'b00;
	case(opcode)
		7'b0110011, 7'b0111011: begin // R-Type
			if (funct7 == 7'b0000001) begin 
				ALUResultSrc_D = 1;
				case (funct3) 
					3'b000: begin // mul
						start_mult_D = 1;
						mult_func_D = 2'b00;
						// calc_result_src_D = 2'b01;
					end
					3'b001: begin // mulh
						start_mult_D = 1;
						mult_func_D = 2'b01;
						// calc_result_src_D = 2'b01;
					end
					3'b011: begin // mulhu
						start_mult_D = 1;
						mult_func_D = 2'b10;
						// calc_result_src_D = 2'b01;
					end	
					3'b010: begin // mulhsu
						start_mult_D = 1;
						mult_func_D = 2'b11;
						// calc_result_src_D = 2'b01;
					end	
					3'b100: begin // div
						start_div_D = 1;
						div_func_D = 2'b00;
						// calc_result_src_D = 2'b10;
					end	
					3'b101: begin // divu
						start_div_D = 1;
						div_func_D = 2'b01;
						// calc_result_src_D = 2'b10;
					end	
					3'b110: begin // rem
						start_div_D = 1;
						div_func_D = 2'b10;
						// calc_result_src_D = 2'b10;
					end	
					3'b111: begin // remu
						start_div_D = 1;
						div_func_D = 2'b11;
						// calc_result_src_D = 2'b10;
					end	
				endcase			
			end
			else begin
				// RegWrite = 1;
				ImmSrc = 2'b00;
				// ALUSrcB = 0;
				// ALUSrcA = 2'b01;
				// MemWrite = 0;
				// ResultSrc = 2'b01;
				// ResultSrc = 2'b00;
				// Branch = 0;
				ALUOp = 2'b10;
				// Jump = 0;
				// PCJalSrc_D = 0;
			end
			RegWrite = 1;
			ALUSrcB = 0;
			ALUSrcA = 2'b01;
			Branch = 0;
			Jump = 0;
			PCJalSrc_D = 0;
			MemWrite = 0;
			ResultSrc = 2'b00;
		end

		7'b0010011: begin // I-Type
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

		7'b0100011: begin // S-Type
			RegWrite = 0;
			ImmSrc = 2'b01;
			ALUSrcB = 1;
			ALUSrcA = 2'b01;
			MemWrite = 1;
			Branch = 0;
			ALUOp = 2'b00;
			Jump = 0;
			PCJalSrc_D = 0;
			write_type_D = (funct3 == 3'b000) ? 2'b00 : ((funct3 == 3'b001) ? 2'b01 : ((funct3 == 3'b010) ? 2'b10 : 2'b11));
		end

		7'b0000011: begin // L-Type
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

		7'b1100011: begin // B-Type
			RegWrite = 0;
			ImmSrc=2'b10;
			ALUSrcB=0;
			ALUSrcA = 2'b01;
			MemWrite=0;
			Branch=1;
			ALUOp=2'b11;
			Jump = 0;
			PCJalSrc_D = 0;
		end

		7'b1101111: begin // J-Type
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
			RegWrite = 0;
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