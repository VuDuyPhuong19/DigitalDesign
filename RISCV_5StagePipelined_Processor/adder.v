module adder #(
	parameter ADDER_DATA_WIDTH = 32
)(
	input [ADDER_DATA_WIDTH-1:0] opA,
	input [ADDER_DATA_WIDTH-1:0] opB,
	output [ADDER_DATA_WIDTH-1:0] adder_out
);

assign adder_out = opA + opB;

endmodule 