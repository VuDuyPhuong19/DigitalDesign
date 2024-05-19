module alu #(
	parameter OP_WIDTH = 32,
	parameter ALUControl_WIDTH = 3,
	parameter ALU_RESULT_WIDTH = 32
)(
	input [OP_WIDTH-1:0] opA, opB,
	input [ALUControl_WIDTH-1:0] ALUControl,
	output zero,
	output reg [ALU_RESULT_WIDTH-1:0] ALU_result
);

assign zero = (ALU_result == 32'b0);
   
always @ (*) begin
	case(ALUControl)
		// ADD
		3'b000: ALU_result = opA + opB; 
		// SUB
		3'b001: ALU_result = opA - opB;
		// OR
		3'b010: ALU_result = opA | opB;
		// AND 
		3'b011: ALU_result = opA & opB;
		// SLT
		3'b101: ALU_result = (opA < opB) ? 1 : 0;

		default: ALU_result = 0;
	endcase
end

endmodule