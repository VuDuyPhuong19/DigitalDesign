module case_(
	input [3:0] a,b,
	input [1:0] s,
	output reg [3:0] c
);

always @ (a or b or s)
begin
	case(s)
		2'b00: c = a + b;
		2'b01: c = a - b;
		2'b10: c = a * b;
		default: c = ~a;
	endcase
end
endmodule