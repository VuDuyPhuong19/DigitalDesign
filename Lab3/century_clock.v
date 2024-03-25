module century_clock #(
	parameter led_num = 6,
	parameter segment_num = 7
)(
	input clk_50MHz,
	input rst_n,
	output [led_num*segment_num-1:0] six_led
);

wire pulse;

one_second_pulse one_second_pulse(
	.clk_50MHz(clk_50MHz),
	.rst_n(rst_n),
	.pulse(pulse)
);

/*
count_60s count_60s(
	.clk_1Hz(pulse),
	.rst_n(rst_n),
	.second_led(two_led)
);
*/

/*
count_60_min count_60_min(
	.clk_1Hz(pulse),
	.rst_n(rst_n),
	.minute_led(four_led)
);
*/

count_24_hours count_24_hours(
	.clk_1Hz(pulse),
	.rst_n(rst_n),
	.hour_led(six_led)
);

endmodule