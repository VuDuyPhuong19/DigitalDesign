// architecture (draw.io) 
// https://app.diagrams.net/#G1OU_oI-Piuf8ZVvSfukQoe2DTeIAQKjZS#%7B%22pageId%22%3A%22jCtttE93AKi2Yj6rNEwo%22%7D

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
wire enable_h, enable_n;
wire start_y, start_g, start_y_h, start_g_h, start_y_n, start_g_n; 
wire [LIGHT_BIT-1:0] light_h, light_n;
wire clk_1Hz;

assign start_y = start_y_h | start_y_n;
assign start_g = start_g_h | start_g_n;

one_second_pulse one_second_pulse(.clk_50MHz(clk), .rst_n(rst_n), .clk_1Hz(clk_1Hz));

// Datapath
timer timer(.clk(clk_1Hz), .start_y(start_y), .start_g(start_g), .Timeout(Timeout), .timeout(timeout)); 

// FSM
highway_controller highway_controller( .clk(clk_1Hz),
									   .rst_n(rst_n),
									   .car(car),
									   .Timeout(Timeout),
									   .timeout(timeout),
									   .enable_h(enable_h),
									   .start_y_h(start_y_h),
									   .start_g_h(start_g_h),
									   .enable_n(enable_n),
									   .light_h(light_h)
); 

// FSM
countryroad_controller countryroad_controller( .clk(clk_1Hz),
											   .rst_n(rst_n),
											   .car(car),
											   .Timeout(Timeout),
											   .timeout(timeout),
											   .enable_n(enable_n),
											   .start_y_n(start_y_n),
											   .start_g_n(start_g_n),
											   .enable_h(enable_h),
											   .light_n(light_n)
); 

assign green_h_led = (light_h == GREEN_LIGHT) ? 1 : 0;
assign yellow_h_led = (light_h == YELLOW_LIGHT) ? 1 : 0;
assign red_h_led = (light_h == RED_LIGHT) ? 1 : 0;

assign green_n_led = (light_n == GREEN_LIGHT) ? 1 : 0;
assign yellow_n_led = (light_n == YELLOW_LIGHT) ? 1 : 0;
assign red_n_led = (light_n == RED_LIGHT) ? 1 : 0;

seven_segment T(.value(Timeout), .led(led_out[13:7]));
seven_segment t(.value(timeout), .led(led_out[6:0]));

endmodule

// module TrafficLight_tb();
// reg clk, rst_n, car;
// wire [13:0] led_out;
// wire green_h_led, yellow_h_led, red_h_led, green_n_led, yellow_n_led, red_n_led;

// TrafficLight dut(.clk(clk),
// 				 .rst_n(rst_n),
// 				 .car(car),
// 				 .led_out(led_out),
// 				 .green_h_led(green_h_led),
// 				 .yellow_h_led(yellow_h_led),
// 				 .red_h_led(red_h_led),
// 				 .green_n_led(green_n_led),
// 				 .yellow_n_led(yellow_n_led),
// 				 .red_n_led(red_n_led)
// );

// initial begin
// 	clk = 0;
// 	forever #5 clk = ~clk;
// end

// initial begin
// 	rst_n = 0;
// 	car = 1;
// 	#10 rst_n = 1;
// 	#100 car = 0;
		
// 	#10000 $finish;
// end

// endmodule