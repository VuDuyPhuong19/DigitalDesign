module Case(
			input [3:0] A,B,
			input [2:0] opcode, 
			output reg [4:0] result
);

always @(A,B,opcode) 

begin

case (opcode)

	3'b000: result =A+B;
	3'b001: result =A-B;
	3'b010: result =A&B;
	3'b011: result =A|B;
	3'b100: result =A^B;
	3'b101: result =~A;
	default: result =5'b0;
endcase
end
endmodule
	
	