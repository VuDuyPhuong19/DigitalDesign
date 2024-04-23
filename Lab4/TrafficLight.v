module TrafficLight(
	input clk,
	input rst_n,
	input car,
	output [13:0] led_out,
	output green_h_led, yellow_h_led, red_h_led, green_n_led, yellow_n_led, red_n_led   
);

parameter TIMEOUT_BIT = 4;
parameter t_bit = 2;
parameter GREEN_LIGHT = 3'b001;
parameter YELLOW_LIGHT = 3'b010;
parameter RED_LIGHT = 3'b100;
parameter LIGHT_BIT = 3;

wire [TIMEOUT_BIT-1:0] Timeout;
wire [t_bit-1:0] timeout;
wire clk_1s_enable;
wire enable_h, enable_n;
wire start, start_h, start_n; 
wire [LIGHT_BIT-1:0] light_h, light_n;

assign start = start_h | start_n;

clk_1s clk_1s(.clk(clk), .rst_n(rst_n), .clk_1s_enable(clk_1s_enable));

// Datapath
timer timer(.clk(clk), .start(start), .clk_1s_enable(clk_1s_enable), .Timeout(Timeout), .timeout(timeout)); 

// FSM
highway_controller highway_controller( .clk(clk),
									   .rst_n(rst_n),
									   .car(car),
									   .Timeout(Timeout),
									   .timeout(timeout),
									   .enable_h(enable_h),
									   .start_h(start_h),
									   .enable_n(enable_n),
									   .light_h(light_h)
); 

// FSM
countryroad_controller countryroad_controller( .clk(clk),
									   .rst_n(rst_n),
									   .car(car),
									   .Timeout(Timeout),
									   .timeout(timeout),
									   .enable_n(enable_n),
									   .start_n(start_n),
									   .enable_h(enable_h),
									   .light_n(light_n)
); 

assign green_h_led = (light_h == GREEN_LIGHT) ? 0 : 1;
assign yellow_h_led = (light_h == YELLOW_LIGHT) ? 0 : 1;
assign red_h_led = (light_h == RED_LIGHT) ? 0 : 1;

assign green_n_led = (light_n == GREEN_LIGHT) ? 0 : 1;
assign yellow_n_led = (light_n == YELLOW_LIGHT) ? 0 : 1;
assign red_n_led = (light_n == RED_LIGHT) ? 0 : 1;

seven_segment T(.value(Timeout), .led(led_out[13:7]));
seven_segment t(.value(timeout), .led(led_out[6:0]));

endmodule

module TrafficLight_tb();
reg clk, rst_n, car;
wire [13:0] led_out;
wire green_h_led, yellow_h_led, red_h_led, green_n_led, yellow_n_led, red_n_led;

TrafficLight dut(.clk(clk),
				 .rst_n(rst_n),
				 .car(car),
				 .led_out(led_out),
				 .green_h_led(green_h_led),
				 .yellow_h_led(yellow_h_led),
				 .red_h_led(red_h_led),
				 .green_n_led(green_n_led),
				 .yellow_n_led(yellow_n_led),
				 .red_n_led(red_n_led)
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 0;
	car = 1;
	#10 rst_n = 1;
	#100 car = 0;
		
	#1000 $finish;
end

endmodule