// FSM
module highway_controller #(                   
	parameter TIMEOUT_BIT = 4,
	parameter t_bit = 2,
	parameter LIGHT_BIT = 3
)(
	input clk,
	input rst_n,
	input car,
	input [TIMEOUT_BIT-1:0] Timeout,
	input [t_bit-1:0] timeout,
	input enable_h,
	output reg start_y_h, // kích hoạt đếm 
	output reg start_g_h,
	output reg enable_n,
	output reg [LIGHT_BIT-1:0] light_h
);

parameter STATE_NUM = 3;
parameter GREEN_H = 3'b001;
parameter YELLOW_H = 3'b010;
parameter RED_H = 3'b100;
parameter GREEN_LIGHT = 3'b001;
parameter YELLOW_LIGHT = 3'b010;
parameter RED_LIGHT = 3'b100;

reg [STATE_NUM-1:0] current_state, next_state;

always @ (posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		current_state <= GREEN_H;
	end
	else begin
		current_state <= next_state;
	end
end

always @ (current_state or next_state or enable_h or car or Timeout or timeout) begin
	next_state = current_state;
	start_y_h = 0;
	start_g_h = 0;
	enable_n = 0;
	case(current_state)
		GREEN_H: begin
			light_h = GREEN_LIGHT;
			if (~car && Timeout == 0) begin
				next_state = YELLOW_H;
				start_y_h = 1;
			end 
			// else begin
			// 	next_state <= current_state;
			// 	start_h = 0;
			// end
		end
		YELLOW_H: begin
			light_h = YELLOW_LIGHT;
			if (timeout == 0) begin
				next_state = RED_H;
				enable_n = 1;
			end
			// else begin
			// 	next_state = current_state;
			// 	enable_n = 0;
			// end
		end
		RED_H:begin
			light_h = RED_LIGHT;
			if (enable_h) begin
				next_state = GREEN_H;
				start_g_h = 1;
			end
			// else begin
			// 	next_state = current_state;
			// 	start_h = 0;
			// end
		end
	endcase
end

endmodule

module highway_controller_tb ();
reg clk, rst_n, car;
parameter TIMEOUT_BIT = 4;
parameter t_bit = 2;
parameter LIGHT_BIT = 3;
reg [TIMEOUT_BIT-1:0] Timeout;
reg [t_bit-1:0] timeout;
reg enable_h;
wire start_h, enable_n;
wire [LIGHT_BIT-1:0] light_h;
integer i, j;

highway_controller uut(.clk(clk), 
				   .rst_n(rst_n), 
				   .car(car), 
				   .Timeout(Timeout), 
				   .timeout(timeout), 
				   .enable_h(enable_h), 
				   .start_h(start_h),
				   .enable_n(enable_n),
				   .light_h(light_h)
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 0;
	car = 1;
	#10 rst_n = 1;
	#35 car = 0;
	for (i = 9; i >= 0; i = i - 1) begin
		#10 Timeout = i;
	end
	for (j = 3; j >= 0; j = j - 1) begin
		#10 timeout = j;
	end
	#100 car = 1;
	#1000 $finish;
end

endmodule
