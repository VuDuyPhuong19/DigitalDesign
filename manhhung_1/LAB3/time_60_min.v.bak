module time_60_min(
	input clk_1min,
	input rst_60p,
	input stop,
    input adjust_clk,
	output reg [6:0]one_min,
	output reg [6:0]ten_min,
	output reg next_hour
);
localparam MAX_S=9;
localparam MAX_T=5;
reg [6:0] counter;
wire intermediate_clk;

// Chọn clock dựa trên trạng thái của stop
assign intermediate_clk = stop ? adjust_clk : clk_1min;
always @(posedge intermediate_clk or negedge rst_60p) begin
	if(~rst_60p) begin
		one_min<=0;
		ten_min<=0;
		next_hour=0;
	end
	else begin
		if(one_min==MAX_S) begin
		  one_min=0;
			if(ten_min==MAX_T) begin
				ten_min<=0;
				next_hour=1;
			end
			else begin
				ten_min<=ten_min+1;
				next_hour=0;
			end
		end
		else begin 
			one_min<=one_min+1;
			next_hour=0;
		end
	end
end
endmodule
`timescale 1ns/1ps
module test_1_bench_60_counter();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire clk_min;
reg stop;
reg adjust_clk;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
time_60_min display(
  .stop(stop),
  .adjust_clk(adjust_clk),
  .clk_1min(clk),
  .rst_60p(rst),
  .one_min(led_1),
  .ten_min(led_2),
  .next_hour(clk_min)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#6;
#200000 stop=0;
#20000 stop=1;
#2000 adjust_clk=0;
#2000 forever adjust_clk=#2000 ~adjust_clk;
end
endmodule