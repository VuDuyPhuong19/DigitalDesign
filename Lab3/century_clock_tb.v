`timescale 1ns/1ns
module century_clock_tb();

parameter led_num = 8;
parameter segment_num = 7;
reg clk_50MHz;
reg rst_n;
reg state_button;
reg set_button;
wire [led_num*segment_num-1:0] led;

initial begin
	clk_50MHz = 0;
	forever clk_50MHz = #1 ~clk_50MHz;
end

century_clock dut (.clk_50MHz(clk_50MHz), .rst_n(rst_n), .state_button(state_button), .set_button(set_button), .led(led));

initial $monitor("time=%t, rst_n=%d, state_button=%d, set_button=%d, led=%b", $time, rst_n, state_button, set_button, led);

// always @ (posedge clk_50MHz) begin
// 	if (~rst_n) begin
// 		state_button <= 1;
// 		set_button <= 1;
// 	end
// 	else begin
		
// 	end
// end

initial begin
	rst_n = 1;
	state_button = 1;
	set_button = 1;
	#10 rst_n = 0;
	#10 rst_n = 1;

	// #50 state_button = 0;
	// #20 set_button = 0;
	// #50 state_button = 1;
	// #30 set_button = 1;
	// #50 state_button = 0;
	// #30 set_button = 0;
	#10000 $finish; 
end

endmodule 