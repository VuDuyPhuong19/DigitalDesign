module STATE_OF_CLK(
	input clk_s,
    input rst_s,
	input stop,
    input show_date,
    input adjust_hour,
    input adjust_day,
    input adjust_min,
    input adjust_hour_clk,
    input adjust_min_clk,
    input adjust_day_clk,
    output wire [6:0] LED_1,
    output wire [6:0] LED_2,
    output wire [6:0] LED_3,
    output wire [6:0] LED_8,
    output wire [6:0] LED_4,
    output wire [6:0] LED_5,
    output wire [6:0] LED_6,
    output wire [6:0] LED_7
);
wire [3:0] one_second_s;
wire [3:0] ten_second;
wire [3:0] one_min;
wire [3:0] ten_min;
wire [3:0] one_hour;
wire [3:0] ten_hour;
wire [3:0] one_day;
wire [3:0] ten_day;
wire [3:0] one_month;
wire [3:0] ten_month;
wire [3:0] one_year;
wire [3:0] ten_year;
wire [3:0] hundred_year;
wire [3:0] million_year;
reg [3:0] display_led[7:0];
wire next_minutes;
wire next_hour;
wire next_day;
wire next_sec;
wire adjust_min_1;
wire adjust_hour_1;
wire adjust_day_1;
Debounce fillter1(
	.clk(clk_s),
	.rst(rst_s),
	.clk_in(adjust_min),
	.clk_out(adjust_min_1)
);
Debounce fillter2(
	.clk(clk_s),
	.rst(rst_s),
	.clk_in(adjust_hour),
	.clk_out(adjust_hour_1)
);
Debounce fillter3(
	.clk(clk_s),
	.rst(rst_s),
	.clk_in(adjust_day),
	.clk_out(adjust_day_1)
);
Clock_1Hz counter_1hz(
	.sys_clk(clk_s),
	.rst_n(rst_s),
	.clk_1hz(next_sec)
);
time_60s counter_sec(
    .stop(stop),
    .clk_1hz(next_sec),
	.rst_60s(rst_s),
	.one_second(one_second_s),
	.ten_second(ten_second),
	.next_minutes(next_minutes)
);
time_60_min counter_min(
    .stop(adjust_min_1),
    .adjust_clk(adjust_min_clk),
	.clk_1min(next_minutes),
	.rst_60p(rst_s),
	.one_min(one_min),
	.ten_min(ten_min),
	.next_hour(next_hour)
);
time_24h counter_hour(
    .stop(adjust_hour_1),
    .adjust_clk(adjust_hour_clk),
	.clk_1h(next_hour),
	.rst_24h(rst_s),
	.one_hour(one_hour),
	.ten_hour(ten_hour),
	.next_day(next_day)
);
calendar counter_day_s(
    .stop(adjust_day_1),
    .adjust_clk(adjust_day_clk),
    .clk_day(next_day),
    .rst_calendar(rst_s),
    .one_date(one_day),
    .ten_date(ten_day),
    .one_month(one_month),
    .ten_month(ten_month),
    .one_year(one_year),
    .ten_year(ten_year),
    .hundred_year(hundred_year),
    .million_year(million_year)
);
Led led1(
    .number(display_led[0]),
    .hex(LED_1)
);
Led led2(
    .number(display_led[1]),
    .hex(LED_2)
);
Led led3(
    .number(display_led[2]),
    .hex(LED_3)
);
Led led4(
    .number(display_led[3]),
    .hex(LED_4)
);
Led led5(
    .number(display_led[4]),
    .hex(LED_5)
);
Led led6(
    .number(display_led[5]),
    .hex(LED_6)
);
Led led7(
    .number(display_led[6]),
    .hex(LED_7)
);
Led led8(
    .number(display_led[7]),
    .hex(LED_8)
);
localparam SHOW_TIM=0,SHOW_DATE=1,ADJUST_SEC=2,ADJUST_MIN=3,ADJUST_HOUR=4,ADJUST_DAY=5;
reg current_state=SHOW_TIM,next_state=SHOW_TIM;
always@(posedge clk_s or negedge rst_s) begin
    if(~rst_s) begin
        current_state<=SHOW_TIM;
    end
    else begin
        current_state<=next_state;
        case(current_state) 
            SHOW_TIM: begin
                display_led[0]<=one_second_s;
                display_led[1]<=ten_second;
                display_led[2]<=one_min;
                display_led[3]<=ten_min;
                display_led[4]<=one_hour;
                display_led[5]<=ten_hour;
                display_led[6]<=0;
                display_led[7]<=0;
            end
            SHOW_DATE: begin
                display_led[0]<=one_day;
                display_led[1]<=ten_day;
                display_led[2]<=one_month;
                display_led[3]<=ten_month;
                display_led[4]<=one_year;
                display_led[5]<=ten_year; 
                display_led[6]<=hundred_year; 
                display_led[7]<=million_year; 
				end
            ADJUST_DAY: begin
					//bo sung sau
                display_led[0]<=one_day;
                display_led[1]<=ten_day;
                display_led[2]<=0;
                display_led[3]<=0;
                display_led[4]<=0;
                display_led[5]<=0;
                display_led[6]<=0;
                display_led[7]<=0;
				end
            ADJUST_HOUR: begin 
					//bo sung sau
                display_led[4]<=one_hour;
                display_led[5]<=ten_hour;
                display_led[2]<=0;
                display_led[3]<=0;
                display_led[4]<=0;
                display_led[5]<=0;
                display_led[6]<=0;
                display_led[7]<=0;
				end
            ADJUST_MIN: begin
					//bo sung sau 
                display_led[2]<=one_min;
                display_led[3]<=ten_min; 
                display_led[2]<=0;
                display_led[3]<=0;
                display_led[4]<=0;
                display_led[5]<=0;
                display_led[6]<=0;
                display_led[7]<=0;
				end
				     default: begin
				    display_led[0]<=one_second_s;
                display_led[1]<=ten_second;
                display_led[2]<=one_min;
                display_led[3]<=ten_min;
                display_led[4]<=one_hour;
                display_led[5]<=ten_hour; 
                display_led[6]<=0;
                display_led[7]<=0;
              end
		endcase    
    end
end
always@(current_state or show_date) begin
    if(~rst_s) begin
        next_state=SHOW_TIM;
    end
    else begin
        if(stop) begin
            if(adjust_hour) begin
                next_state=ADJUST_HOUR;
            end
            else begin
                if(adjust_day) begin
                    next_state=ADJUST_DAY;
                end
                else begin
                    next_state=ADJUST_MIN;
                end
            end
        end
        else begin
            if(show_date) begin
                next_state=SHOW_DATE;
            end
            else begin
                next_state=SHOW_TIM;
            end
        end
    end
end
endmodule
`timescale 1ns/1ps
module STATE_CLK_test();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire [6:0] led_3;
wire [6:0] led_4;
wire [6:0] led_5;
wire [6:0] led_6;
wire [6:0] led_7;
wire [6:0] led_8;
//wire clk_min;
reg stop;
reg change_show;
reg adjust_min;
reg stop_min;
initial begin
  clk=0;
  forever clk= #2 ~clk;
end
STATE_OF_CLK display(
  .clk_s(clk),
  .rst_s(rst),
  .stop(stop_min),
  .adjust_min(stop),
  .adjust_min_clk(adjust_min),
  .show_date(change_show),
  .LED_1(led_1),
  .LED_2(led_2),
  .LED_3(led_3),
  .LED_4(led_4),
  .LED_5(led_5),
  .LED_6(led_6),
  .LED_7(led_7),
  .LED_8(led_8)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#5 stop=0;
#2 change_show=0;
#4 adjust_min=0;
#4 stop_min=1;
#6;
#200000 stop=0;
#2000 forever adjust_min=#1000 ~adjust_min;
/*adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
adjust_min=#1000 ~adjust_min;
#2000 stop=0; */
end
endmodule