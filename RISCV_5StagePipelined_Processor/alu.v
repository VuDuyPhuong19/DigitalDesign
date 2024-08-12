module alu #(
	parameter OP_WIDTH = 32,
	parameter ALUCONTROL_WIDTH = 4,
	parameter ALU_RESULT_WIDTH = 32,
    parameter ADD_ALU = 4'b0000,
    parameter SUB_ALU = 4'b0001,
    parameter AND_ALU = 4'b0010,
    parameter OR_ALU = 4'b0011,
    parameter XOR_ALU = 4'b0100,
    parameter SLT_ALU = 4'b0101,
    parameter SLL_ALU = 4'b0110,
    parameter SRA_ALU = 4'b0111,
    parameter SGTe_ALU = 4'b1000,
    parameter EQUAL_ALU = 4'b1001,
    parameter NOT_EQUAL_ALU = 4'b1010,
    parameter SRL_ALU = 4'b1011, // srl
    parameter SLTU_ALU = 4'b1100, //sltu
    parameter SGTeU_ALU = 4'b1101 // bgeu
)(
	input [OP_WIDTH-1:0] opA,
	input [OP_WIDTH-1:0] opB,
	input [ALUCONTROL_WIDTH-1:0] ALUControl_E,
	output zero_E,
	output reg signed [ALU_RESULT_WIDTH-1:0] ALU_result_E
);

assign zero_E = (ALU_result_E == 32'b0);
   
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

		default: ALU_result_E = 0;
	endcase
end

endmodule