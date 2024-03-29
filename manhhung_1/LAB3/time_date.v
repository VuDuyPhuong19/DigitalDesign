module time_date(
	input clk_s,
    input rst_s,
    output wire [6:0] one_second,
    output wire [6:0] ten_second,
    output wire [6:0] one_minutes,
    output wire [6:0] ten_minutes,
    output wire [6:0] one_hour,
    output wire [6:0] ten_hour,
    output wire [6:0] one_day,
    output wire [6:0] ten_day,
    output wire [6:0] one_month,
    output wire [6:0] ten_month,
    output wire [6:0] one_year,
    output wire [6:0] ten_year,
    output wire [6:0] hundred_year,
    output wire [6:0] million_year
);
wire next_day_clock;
    Lock_display show_time(
        .clk_1hz_s(clk_s),
        .rst_60s(rst_s),
        .one_led(one_second),
        .ten_led(ten_second),
        .one_led_1(one_minutes),
        .ten_led_1(ten_minutes),
        .one_led_2(one_hour),
        .ten_led_2(ten_hour),
        .next_day(next_day_clock)
    );
    Calendar_display show_date(
        .clk_day_display(next_day_clock),
        .rst_calendar_display(rst_s),
        .one_day_led(one_day),
        .ten_day_led(ten_day),
        .one_month_led(one_month),
        .ten_month_led(ten_month),
        .one_year_led(one_year),
        .ten_year_led(ten_year),
        .hundred_year_led(hundred_year),
        .million_year_led(million_year)
    );
endmodule`timescale 1ns/1ps
module time_date_test();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire [6:0] led_3;
wire [6:0] led_4;
wire [6:0] led_5;
wire [6:0] led_6;
wire [6:0] led_7;
wire [6:0] led_8;
wire [6:0] led_9;
wire [6:0] led_10;
wire [6:0] led_11;
wire [6:0] led_12;
wire [6:0] led_13;
wire [6:0] led_14;
wire clk_min;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
time_date display(
  .clk_s(clk),
  .rst_s(rst),
  .one_second(led_1),
  .ten_second(led_2),
  .one_minutes(led_3),
  .ten_minutes(led_4),
  .one_hour(led_5),
  .ten_hour(led_6),
  .one_day(led_7),
  .ten_day(led_8),
  .one_month(led_9),
  .ten_month(led_10),
  .one_year(led_11),
  .ten_year(led_12),
  .hundred_year(led_13),
  .million_year(led_14)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#6;
end
endmodule