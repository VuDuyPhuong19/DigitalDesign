module display #(
	parameter segment_num = 7,
	parameter n = 4	
)(
	input [n-1:0] led_value0,
	input [n-1:0] led_value1,
	input [n-1:0] led_value2,
	input [n-1:0] led_value3,
	input [n-1:0] led_value4,
	input [n-1:0] led_value5,
	input [n-1:0] led_value6,
	input [n-1:0] led_value7,
	output [segment_num-1:0] led_out0,
	output [segment_num-1:0] led_out1,
	output [segment_num-1:0] led_out2,
	output [segment_num-1:0] led_out3,
	output [segment_num-1:0] led_out4,
	output [segment_num-1:0] led_out5,
	output [segment_num-1:0] led_out6,
	output [segment_num-1:0] led_out7
);

seven_segment led_0(
	.value(led_value0),
	.led(led_out0)
);
seven_segment led_1(
	.value(led_value1),
	.led(led_out1)
);
seven_segment led_2(
	.value(led_value2),
	.led(led_out2)
);

seven_segment led_3(
	.value(led_value3),
	.led(led_out3)
);

seven_segment led_4(
	.value(led_value4),
	.led(led_out4)
);

seven_segment led_5(
	.value(led_value5),
	.led(led_out5)
);

seven_segment led_6(
	.value(led_value6),
	.led(led_out6)
);

seven_segment led_7(
	.value(led_value7),
	.led(led_out7)
);

endmodule