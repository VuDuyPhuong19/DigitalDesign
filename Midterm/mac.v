module mac #(
	parameter DATA_BIT_NUM = 16,
	parameter COEFF_BIT_NUM = 16
)(
	input clk,
	input rst_n,
	input calculated,
	input signed [DATA_BIT_NUM-1:0] data_delay_in,
	input signed [COEFF_BIT_NUM-1:0] coeffs,
	output signed [DATA_BIT_NUM-1:0] data_out
);

wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] product;
assign product = data_delay_in * 
// Multiplier

endmodule 