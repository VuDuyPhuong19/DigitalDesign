module FIR_filter #(
	parameter DATA_BIT_NUM = 16,
	parameter COEFF_BIT_NUM = 16,
	parameter COUNT_BIT_NUM = 6
)(
	input clk,
	input rst_n,
	input [COUNT_BIT_NUM-1:0] count,
	input calculated,
	input signed [DATA_BIT_NUM-1:0] filter_data_in,
	output signed [DATA_BIT_NUM:0] filter_data_out
);

wire [COEFF_BIT_NUM-1:0] coeffs_in;
wire signed [DATA_BIT_NUM-1:0] data_delay_in;
//wire [COUNT_BIT_NUM-1:0] count;
//wire calculated;

// counter counter(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated));

coeffs coeffs(.count(count), .coeffs_in(coeffs_in));

delay delay(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated), .data_in(filter_data_in), .data_delay_in(data_delay_in));

mac mac(.clk(clk), .rst_n(rst_n), .calculated(calculated), .data_delay_in(data_delay_in), .coeffs(coeffs_in), .data_out(filter_data_out));

endmodule 

