module Debounce(
	input clk,
	input rst,
	input clk_in,
	output reg clk_out
 
);
localparam DELAY_TIME=2300;
reg a1;
reg a2;
reg a3;	
reg [20:0] counter;
always@(posedge clk or negedge rst) begin
	if(~rst) begin
		a1<=0;
		a2<=0;
		a3<=0;
	end
	else begin
		a1<=clk_in;
		a2<=a1;
		a3<=a2;
	end
end
always@(posedge clk or negedge rst) begin
	if(~rst) begin
		clk_out<=0;
		counter<=0;
	end
	else begin	
    counter<=counter+1;
		if(counter==DELAY_TIME) begin
			clk_out<=a3;
			counter<=0;
		end
	end
end
endmodule
`timescale 1ns/1ps
module test_debound();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire clk_min;
wire clk_t;
wire [20:0]counter;
reg clk_ad;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
Debounce display(
  .counter(counter),
  .clk(clk),
  .rst(rst),
  .clk_in(clk_ad),
  .clk_out(clk_t)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#1000;
#20000 clk_ad=0;
#20000 clk_ad=1;
end
endmodule
