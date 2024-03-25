module count_day #(
	parameter led_num = 2,
	parameter segment_num = 7
)(
	input clk_1Hz,
	input rst_n,
	output reg [led_num*segment_num-1:0] day_led
);



endmodule
