module alu #(
	parameter OP_WIDTH = 32,
	parameter ALUCONTROL_WIDTH = 4,
	parameter ALU_RESULT_WIDTH = 32,
	parameter ADD_ALU = 3'b0000,
    parameter SUB_ALU = 3'b0001,
    parameter AND_ALU = 3'b0010,
    parameter OR_ALU = 3'b0011,
    parameter XOR_ALU = 3'b0100,
    parameter SLT_ALU = 3'b0101,
    parameter SHL_ALU = 3'b0110,
    parameter SHR_ALU = 3'b0111,
    parameter SGTe_ALU = 3'b1000,
    parameter EQUAL_ALU = 3'b1001,
    parameter NOT_EQUAL_ALU = 3'b1010
)(
	input [OP_WIDTH-1:0] opA, opB,
	input [ALUCONTROL_WIDTH-1:0] ALUControl,
	output zero,
	output reg [ALU_RESULT_WIDTH-1:0] ALU_result
);

assign zero = (ALU_result == 32'b0);
   
always @ (*) begin
	case(ALUControl)
		// ADD
		ADD_ALU: ALU_result = opA + opB; 
		// SUB
		SUB_ALU: ALU_result = opA - opB;
		// OR
		OR_ALU: ALU_result = opA | opB;
		// AND 
		AND_ALU: ALU_result = opA & opB;
		// XOR
		XOR_ALU: ALU_result = opA ^ opB;
		// SLT
		SLT_ALU: ALU_result = (opA < opB) ? 1 : 0;
		// SHL
		SHL_ALU: ALU_result = opA << opB;
		// SHR
		SHR_ALU: ALU_result = opA >> opB;
		// SGTe
		SGTe_ALU: ALU_result = (opA >= opB) ? 1 : 0;
		// EQUAL
		EQUAL_ALU: ALU_result = (opA == opB) ? 1 : 0;
		// NOT_EQUAL
		NOT_EQUAL_ALU: ALU_result = (opA != opB) ? 1 : 0;

		default: ALU_result = 0;
	endcase
end

endmodule