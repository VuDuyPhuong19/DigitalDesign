module time_60s(
    input clk_1hz,
    input rst_60s,
    input stop,
    input adjust_clk,
    output reg [6:0] one_second,
    output reg [6:0] ten_second,
    output reg next_minutes
);

localparam MAX_S = 9;
localparam MAX_T = 5;

reg [6:0] counter;
reg stop_pending = 0;
wire intermediate_clk;

// Chọn clock dựa trên trạng thái của stop
assign intermediate_clk = stop ? adjust_clk : clk_1hz;

always @(posedge intermediate_clk or negedge rst_60s) begin
    if (~rst_60s) begin
        one_second <= 0;
        ten_second <= 0;
        next_minutes <= 0;
    end else if (!stop_pending) begin
        if (one_second == MAX_S) begin
            one_second <= 0;
            if (ten_second == MAX_T) begin
                ten_second <= 0;
                next_minutes <= 1;
            end else begin
                ten_second <= ten_second + 1;
                next_minutes <= 0;
            end
        end else begin
            one_second <= one_second + 1;
            next_minutes <= 0;
        end
    end
end

endmodule

`timescale 1ns/1ps
module test_bench_60_counter();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire clk_min;
reg stop;
reg clk_ad;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
time_60s display(
  .clk_1hz(clk),
  .rst_60s(rst),
  .one_second(led_1),
  .ten_second(led_2),
  .next_minutes(clk_min),
  .stop(stop),
  .adjust_clk(clk_ad)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#1000;
#20000 stop=1;
#20000 stop=0;
//forever clk_ad=#200~clk_ad;
end
endmodule
