module Calendar_display(
    input clk_day_display,
    input rst_calendar_display,
    input stop,
    input adjust_clk,
    output wire [6:0] one_day_led,
    output wire [6:0] ten_day_led,
    output wire [6:0] one_month_led,
    output wire [6:0] ten_month_led,
    output wire [6:0] one_year_led,
    output wire [6:0] ten_year_led,
    output wire [6:0] hundred_year_led,
    output wire [6:0] million_year_led
);
wire [3:0] one_day;
wire [3:0] ten_day;
wire [3:0] one_month;
wire [3:0] ten_month;
wire [3:0] one_year;
wire [3:0] ten_year;
wire [3:0] hundred_year;
wire [3:0] million_year;
wire intermediate_clk;
// Chọn clock dựa trên trạng thái của stop
assign intermediate_clk = stop ? adjust_clk : clk_day_display;
calendar counter_day(
    .clk_day(clk_day_display),
    .rst_calendar(rst_calendar_display),
    .one_date(one_day),
    .ten_date(ten_day),
    .one_month(one_month),
    .ten_month(ten_month),
    .one_year(one_year),
    .ten_year(ten_year),
    .hundred_year(hundred_year),
    .million_year(million_year)
);
Led led_1(
    .number(one_day),
    .hex(one_day_led)
);
Led led_2(
    .number(ten_day),
    .hex(ten_day_led)
);
Led led_3(
    .number(one_month),
    .hex(one_month_led)
);
Led led_4(
    .number(ten_month),
    .hex(ten_month_led)
);
Led led_5(
    .number(one_year),
    .hex(one_year_led)
);
Led led_6(
    .number(ten_year),
    .hex(ten_year_led)
);
Led led_7(
    .number(hundred_year),
    .hex(hundred_year_led)
);
Led led8(
    .number(million_year),
    .hex(million_year_led)
);
endmodule
`timescale 1ns/1ps
module display_test_bench();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire [6:0] led_3;
wire [6:0] led_4;
wire [6:0] led_5;
wire [6:0] led_6;
wire [6:0] led_7;
wire [6:0] led_8;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
Calendar_display display(
  .clk_day_display(clk),
  .rst_calendar_display(rst),
  .one_day_led(led_1),
  .ten_day_led(led_2),
  .one_month_led(led_3),
  .ten_month_led(led_4),
  .one_year_led(led_5),
  .ten_year_led(led_6),
  .hundred_year_led(led_7),
  .million_year_led(led_8)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#6;
end
endmodule