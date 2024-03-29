module Lock_display(
	input clk_1hz_s,
	input rst_60s,
	input stop,
	input adjust_clk,
	output wire [6:0]one_led,
	output wire [6:0]ten_led,
	output wire [6:0]one_led_1,
	output wire [6:0]ten_led_1,
	output wire [6:0]one_led_2,
	output wire [6:0]ten_led_2,
	output wire next_day
);
wire [3:0] one_second_s;
wire [3:0] ten_second_s;
wire [3:0] one_min_s;
wire [3:0] ten_min_s;
wire [3:0] one_hour_s;
wire [3:0] ten_hour_s;
wire next_minutes_s;
wire next_hour_s;
wire next_day_s;
time_60s counter_k(
	.clk_1hz(clk_1hz_s),
	.rst_60s(rst_60s),
	.one_second(one_second_s),
	.ten_second(ten_second_s),
	.next_minutes(next_minutes_s),
	.stop(stop),
	.adjust_clk(adjust_clk)
);
time_60_min counter_1(
	.clk_1min(next_minutes_s),
	.rst_60p(rst_60s),
	.one_min(one_min_s),
	.ten_min(ten_min_s),
	.next_hour(next_hour_s)
);
time_24h counter_2(
	.clk_1h(next_hour_s),
	.rst_24h(rst_60s),
	.one_hour(one_hour_s),
	.ten_hour(ten_hour_s),
	.next_day(next_day)
);
Led led_1(
	.number(one_second_s),
	.hex(one_led)
);
Led led_2(
	.number(ten_second_s),
	.hex(ten_led)
);
Led led_3(
	.number(one_min_s),
	.hex(one_led_1)
);
Led led_4(
	.number(ten_min_s),
	.hex(ten_led_1)
);
Led led_5(
	.number(one_hour_s),
	.hex(one_led_2)
);
Led led_6(
	.number(ten_hour_s),
	.hex(ten_led_2)
);
endmodule
`timescale 1ns/1ps
module test_bench();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire [6:0] led_3;
wire [6:0] led_4;
wire [6:0] led_5;
wire [6:0] led_6;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
Lock_display display(
  .clk_1hz_s(clk),
  .rst_60s(rst),
  .one_led(led_1),
  .ten_led(led_2),
  .one_led_1(led_3),
  .ten_led_1(led_4),
  .one_led_2(led_5),
  .ten_led_2(led_6)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#6;
end
endmodule

