module count_24_hours #(	
	parameter sec_num = 6,
	parameter min_num = 6,
	parameter hour_num = 5,
	parameter state_num = 8
)(
	input clk_1Hz,
	input rst_n,
	input [$clog2(state_num)-1:0] state,
	input set_button,
	output reg [sec_num-1:0] seconds,
	output reg [min_num-1:0] minutes,
	output reg [hour_num-1:0] hours
);

localparam TIME_VIEW = 0, SET_HOUR = 1, SET_MINUTE = 2, SET_SECOND = 3;   

parameter second_max = 60;
parameter minute_max = 60;
parameter hour_max = 24;

reg set_button_last; // luu trang thai cuoi cung cua set_button

initial begin
	seconds = 0;
	minutes = 0;
	hours = 0;
	set_button_last = 1;
end

always @ (posedge clk_1Hz or negedge rst_n) begin
	if (~rst_n) begin
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
		set_button_last <= 1;
	end
	else begin
		if (~set_button && set_button_last) begin // phat hien canh xuong cua set_button
			case (state) 
				SET_HOUR: begin
					hours <= hours + 1;
					if (hours == hour_max) begin
						hours <= 0;
					end
				end
				SET_MINUTE: begin
					minutes <= minutes + 1;
					if (minutes == minute_max - 1) begin
						minutes <= 0;
					end
				end
				SET_SECOND: begin
					seconds <= seconds + 1; 
					if (seconds == second_max - 1) begin
						seconds <= 0;
					end	
				end
//				default: state = TIME_VIEW;
			endcase
		end
		else if (set_button && ~set_button_last) begin // reset set_button_last khi nha nut set_button
			set_button_last <= 1;
		end
		else if (~set_button) begin // giu nguyen gia tri cua set_button_last khi giu nut set_button
			set_button_last <= 0;
		end
		else begin
			seconds <= seconds + 1;
			if (seconds == second_max - 1) begin 
				seconds <= 0;
				minutes <= minutes + 1;
			end	
			if (minutes == minute_max - 1) begin 
				minutes <= 0;
				hours <= hours + 1;
			end
			if (hours == hour_max) begin
				hours <= 0;
			end		
		end
	end
end

endmodule