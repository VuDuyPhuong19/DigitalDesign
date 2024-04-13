module Equalizer #(
	parameter FILTER_NUM = 8,
	parameter DATA_BIT = 16,
	parameter GAIN_BIT = 32,
	parameter COUNT_BIT_NUM = 6
)(
	input clk,
	input rst_n,
	input signed [GAIN_BIT*FILTER_NUM-1:0] gain,
	input signed [DATA_BIT-1:0] data_in,
	output reg signed [DATA_BIT-1:0] data_out
);

wire [COUNT_BIT_NUM-1:0] count;
wire calculated;

counter counter(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated));
wire signed [DATA_BIT-1:0] filter_data_out [0:FILTER_NUM-1];
reg signed [GAIN_BIT-1:0] temp_gain [0:FILTER_NUM-1];
initial begin
    integer i;
    for (i = 0; i < FILTER_NUM; i = i + 1) begin
        temp_gain[i] = gain[(GAIN_BIT*(i+1)-1) -: GAIN_BIT];
    end
end


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
			data_out <= filter_data_out[0] * gain[0] + filter_data_out[1] * gain[1] + filter_data_out[2] * gain[2] + filter_data_out[3] * gain[3] + filter_data_out[4] * gain[4] + filter_data_out[5] * gain[5] + filter_data_out[6] * gain[6] + filter_data_out[7] * gain[7];		
	end
end


endmodule
