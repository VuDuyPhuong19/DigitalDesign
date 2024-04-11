module fsm_pattern(
	input x,
	input clk,
	input rst_n,
	output reg y

);
// ma hoa trang thai bang localparam
	localparam wait_1st_1 = 2'b00;
	localparam wait_0		 = 2'b01;
	localparam wait_2nd_1 = 2'b10;
	
	reg [1:0] state, nextstate;
initial begin
	 y=0;
	 nextstate= wait_0; // thay cho các câu lệnh else nextstate= wait_0 để rút gọn code
	 end
	// mo ta ham trang thai ke tiep delta
	always @( x or state) begin
	// trong khối alway không đồng hồ (clk) luôn dùng phép gán blocking
	// gán giá trị defualt cho;

	case (state)
	
		wait_1st_1:
						if(x==0) nextstate = wait_1st_1;
						//else nextstate= wait_0
		wait_0 : 
						if(x==0) nextstate = wait_2nd_1;
						//else nextstate =wait_0;
		wait_2nd_1:
						if(x==0) nextstate= wait_1st_1;
						else begin nextstate= wait_1st_1;
										y=1;
							  end
	default: nextstate= wait_1st_1;
	endcase
	end
	
	always @(posedge clk or negedge rst_n) begin
	// trong khoi always co dong ho mo ta mach FF
	// luon dung phep gan nonblocking "<="
		if(~rst_n) begin // neu reset =0
			// reset
			state <= wait_1st_1;

		end
		else begin 
				state <= nextstate;
		
		end
	
	
		end 
endmodule
	