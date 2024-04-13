module Equalizer #(
	parameter FILTER_NUM = 8,
	parameter DATA_BIT = 16,
	parameter GAIN_BIT = 5,
	parameter COUNT_BIT_NUM = 6
)(
	input clk,
	input rst_n,
	input [GAIN_BIT*FILTER_NUM-1:0] gain,
	input signed [DATA_BIT-1:0] data_in,
	output reg signed [DATA_BIT-1:0] data_out
);

wire [COUNT_BIT_NUM-1:0] count;
wire calculated;

counter counter(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated));
wire signed [DATA_BIT-1:0] filter_data_out [0:FILTER_NUM-1];


generate
	genvar filter_index;
	for(filter_index = 0; filter_index < FILTER_NUM; filter_index = filter_index + 1) begin : filter_block 
		FIR_filter filter (
			.clk(clk),
			.rst_n(rst_n),
			.count(count),
			.calculated(calculated),
			.filter_data_in(data_in),
			.filter_data_out(filter_data_out[filter_index])	
		);
	end
endgenerate

integer filter_i;

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		data_out <= 0;
	end
	else begin
		for (filter_i = 0; filter_i < FILTER_NUM; filter_i = filter_i + 1) begin
			data_out <= data_out + filter_data_out[filter_i];
		end		
	end
end


endmodule
