module alu #(
	parameter OP_WIDTH = 32,
	parameter OPCODE_WIDTH = 7,
	parameter FUNCT3_WIDTH = 3,
	parameter ALUCONTROL_WIDTH = 6,
	parameter ALU_RESULT_WIDTH = 32,
    parameter ADD_ALU = 6'b000000,
    parameter SUB_ALU = 6'b000001,
    parameter AND_ALU = 6'b000010,
    parameter OR_ALU = 6'b000011,
    parameter XOR_ALU = 6'b000100,
    parameter SLT_ALU = 6'b000101,
    parameter SLL_ALU = 6'b000110,
    parameter SRA_ALU = 6'b000111,
    parameter SGTe_ALU = 6'b001000,
    parameter EQUAL_ALU = 6'b001001,
    parameter NOT_EQUAL_ALU = 6'b00A1010,
    parameter SRL_ALU = 6'b001011, 		// srl
    parameter SLTU_ALU = 6'b001100, 	//sltu
    parameter SGTeU_ALU = 6'b001101, 	// bgeu
    parameter JALR_ALU = 6'b001110, 	// jalr
    parameter SHADD_ALU = 6'b001111, 	// sh1add, sh2add, sh3add
    parameter ANDN_ALU = 6'b010000, 	// andn
	parameter ORN_ALU = 6'b010001, 		// orn
	parameter XNOR_ALU = 6'b010010, 	// xnor
    parameter MAX_ALU = 6'b010011,   	// max, maxu
    parameter MIN_ALU = 6'b010100,    	// min, minu
    parameter SEXT_ALU = 6'b010101,     // sext.b, sext.h
    parameter ZEXT_ALU = 6'b010110,     // zext.h  
	parameter ROL_ALU   = 6'b010111,	// rol
	parameter ROR_ALU   = 6'b011000,  	// ror / rori
	parameter BCLR_ALU  = 6'b011001,  	// bclr 
	parameter BCLRI_ALU = 6'b011010,	// bclri
    parameter BEXT_ALU  = 6'b011011, 	// bext
    parameter BEXTI_ALU = 6'b011100, 	// bexti
    parameter BINV_ALU  = 6'b011101, 	// binv
    parameter BINVI_ALU = 6'b011110, 	// binvi
    parameter BSET_ALU  = 6'b011111, 	// bset
    parameter BSETI_ALU = 6'b100000,	// bseti
)(
	input [OP_WIDTH-1:0] opA,
	input [OP_WIDTH-1:0] opB,
	input [ALUCONTROL_WIDTH-1:0] ALUControl_E,
	input [OPCODE_WIDTH-1:0] opcode_E,
	input [FUNCT3_WIDTH-1:0] funct3_E, 
	// input [4:0] ext_E,
	output zero_E,
	output reg signed [ALU_RESULT_WIDTH-1:0] ALU_result_E
);

assign zero_E = (ALU_result_E == 32'b0) & (opcode_E == 7'b1100011) & (funct3_E == 3'b000);
   
always @ (*) begin
	case(ALUControl_E)
		// ADD
		ADD_ALU: ALU_result_E = opA + opB; 
		// SUB
		SUB_ALU: ALU_result_E = opA - opB;
		// OR
		OR_ALU: ALU_result_E = opA | opB;
		// AND 
		AND_ALU: ALU_result_E = opA & opB;
		// XOR
		XOR_ALU: ALU_result_E = opA ^ opB;
		// SLT
		SLT_ALU: ALU_result_E = ($signed(opA) < $signed(opB)) ? 1 : 0;
		// SLL
		SLL_ALU: ALU_result_E = opA << opB[4:0];
		// SRA
		SRA_ALU: ALU_result_E = $signed(opA) >>> opB[4:0];
		// SGTe
		SGTe_ALU: ALU_result_E = ($signed(opA) >= $signed(opB)) ? 1 : 0;
		// EQUAL
		EQUAL_ALU: ALU_result_E = (opA == opB) ? 1 : 0;
		// NOT_EQUAL
		NOT_EQUAL_ALU: ALU_result_E = (opA != opB) ? 1 : 0;
		// SRL 
		SRL_ALU: ALU_result_E = opA >> opB[4:0];
		// SLTU 
		SLTU_ALU: ALU_result_E = (opA < opB) ? 1 : 0;
		// SGTeU
		SGTeU_ALU: ALU_result_E = (opA >= opB) ? 1 : 0;
		// JALR
		JALR_ALU: ALU_result_E = (opA + opB) & ~1;
		// SH1ADD, SH2ADD, SH3ADD
		SHADD_ALU: begin
			case (funct3_E)
				3'b010: ALU_result_E = (opA << 1) + opB;  // SH1ADD
				3'b100: ALU_result_E = (opA << 2) + opB;  // SH2ADD
				3'b110: ALU_result_E = (opA << 3) + opB;  // SH3ADD
				default: ALU_result_E = 0;
			endcase
		end
		// ANDN
		ANDN_ALU: ALU_result_E = opA & ~opB;
		// ORN
		ORN_ALU: ALU_result_E = opA | ~opB;
		// XNOR
		XNOR_ALU: ALU_result_E = ~(opA ^ opB);
		// MAX / MAXU
		MAX_ALU: begin
            case (funct3_E)
                3'b110: ALU_result_E = ($signed(opA) < $signed(opB)) ? opB : opA; // Signed MAX
                3'b111: ALU_result_E = (opA < opB) ? opB : opA; // Unsigned MAX
                default: ALU_result_E = 0;
            endcase			
		end
		// MIN / MINU
		MIN_ALU: begin
            case (funct3_E)
                3'b100: ALU_result_E = ($signed(opA) < $signed(opB)) ? opA : opB; // Signed MIN
                3'b101: ALU_result_E = (opA < opB) ? opA : opB; // Unsigned MIN
                default: ALU_result_E = 0;
            endcase			
		end
		SEXT_ALU: begin
			case (opB[4:0]) 
				5'b00100: ALU_result_E = {{24{opA[7]}}, opA[7:0]};  	// SEXT.B
				5'b00101: ALU_result_E = {{16{opA[15]}}, opA[15:0]};   	// SEXT.H
				default: ALU_result_E = 0;
			endcase 
		end
		// ZEXT.H
		ZEXT_ALU: ALU_result_E = {{16{1'b0}}, opA[15:0]}; 
		// ROL
		ROL_ALU: ALU_result_E = (opA << opB[4:0]) | (opA >> (32 - opB[4:0]));
		// ROR / RORI
		ROR_ALU: ALU_result_E = (opA >> opB[4:0]) | (opA << (32 - opB[4:0]));  
		// BCLR 
		BCLR_ALU: ALU_result_E = opA & ~(1 << (opB & 31));
		// BCLRI
		BCLRI_ALU: ALU_result_E = opA & ~(1 << (opB[4:0] & 31));
		// BEXT
		BEXT_ALU: ALU_result_E = (opA >> (opB & 31)) & 1; 
		// BEXTI
		BEXTI_ALU: ALU_result_E = (opA >> (opB[4:0] & 31)) & 1;
		// BINV
		BINV_ALU: ALU_result_E = opA ^ (1 << (opB & 31));
		// BINVI
		BINVI_ALU: ALU_result_E = opA ^ (1 << (opB[4:0] & 31));
		// BSET 
		BSET_ALU: ALU_result_E = opA | (1 << (opB & 31));
		// BSETI
		BSETI_ALU: ALU_result_E = opA | (1 << (opB[4:0] & 31));

		default: ALU_result_E = 0;
	endcase
end

endmodule