module multiplier #(
	parameter NUMBER_OF_BIT = 16
)(
	input [NUMBER_OF_BIT-1:0] A,
	input [NUMBER_OF_BIT-1:0] B,
	output [NUMBER_OF_BIT+NUMBER_OF_BIT-1:0] product
);

assign product = A * B;

endmodule