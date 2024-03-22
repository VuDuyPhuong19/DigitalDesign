module top_module_led_2_7seg(
	input [3:0] input_1,
	input [7:4] input_2,
	input [11:8] input_3,
	input [15:12] input_4,
	output [6:0] output_1,
	output [13:7] output_2,
	output [20:14] output_3,
	output [27:21] output_4
);

bin_2_7seg led_1(input_1, output_1);
bin_2_7seg led_2(input_2, output_2);
bin_2_7seg led_3(input_3, output_3);
bin_2_7seg led_4(input_4, output_4);

endmodule