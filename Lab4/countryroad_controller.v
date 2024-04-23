// FSM
module countryroad_controller #(                
	parameter TIMEOUT_BIT = 4,
	parameter t_bit = 2,
	parameter LIGHT_BIT = 3
)(
	input clk,
	input rst_n,
	input car,
	input [TIMEOUT_BIT-1:0] Timeout,
	input [t_bit-1:0] timeout,
	input enable_n,
	output reg start_n, // kích hoạt đếm 
	output reg enable_h,
	output reg [LIGHT_BIT-1:0] light_n
);

parameter STATE_NUM = 3;
parameter GREEN_N = 3'b001;
parameter YELLOW_N = 3'b010;
parameter RED_N = 3'b100;
parameter GREEN_LIGHT = 3'b001;
parameter YELLOW_LIGHT = 3'b010;
parameter RED_LIGHT = 3'b100;

reg [STATE_NUM-1:0] current_state, next_state;

always @ (posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		current_state <= RED_N;
	end
	else begin
		current_state <= next_state;
	end
end

always @ (current_state or next_state or enable_n or car or Timeout or timeout) begin
	next_state = current_state;
	start_n = 0;
	enable_h = 0;
	case (current_state)
		GREEN_N: begin
			light_n = GREEN_LIGHT;
			if (Timeout == 0) begin
				next_state = YELLOW_N;
				start_n = 1;
			end
			// else begin
			// 	next_state = current_state;
			// 	start_n = 0;
			// end
		end
		YELLOW_N: begin
			light_n = YELLOW_LIGHT;
			if (timeout == 0) begin
				next_state = RED_N;
				enable_h = 1;
			end
			// else begin
			// 	next_state = current_state;
			// 	enable_h = 0;
			// end
		end
		RED_N: begin
			light_n = RED_LIGHT;
			if (enable_n) begin
				next_state = GREEN_N;
				start_n = 1;
			end
			// else begin
			// 	next_state = current_state;
			// 	start_n = 0;
			// end
		end
	endcase
end

endmodule