module top_module(
input [15:0] in_switch,
output [27:0] out_led
);
	led7 led_1(in_switch[3:0],out_led[6:0]);
	led7 led_2(in_switch[7:4],out_led[13:7]);
	led7 led_3(in_switch[11:8],out_led[20:14]);
	led7 led_4(in_switch[15:12],out_led[27:21]);
endmodule