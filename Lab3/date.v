module date #(
	parameter hour_num = 5,
	parameter day_num = 6,
	parameter mon_num = 4,
	parameter year_num = 7,
	parameter state_num = 8
)(
	input clk_1Hz,
	input rst_n,
	input [$clog2(state_num)-1:0] state,
	input set_button,
	input [hour_num-1:0] hours,
	output reg [day_num-1:0] days,
	output reg [mon_num-1:0] months,
	output reg [year_num-1:0] years
);

localparam SET_DAY = 5, SET_MONTH = 6, SET_YEAR= 7; 

parameter hour_max = 24;
parameter mon_max = 12;
parameter year_max = 100;

reg set_button_last; // luu trang thai cuoi cung cua set_button

initial begin
	days = 1;
	months = 1;
	years = 0;
	set_button_last = 1;
end

always @ (posedge clk_1Hz or negedge rst_n) begin
	if (~rst_n) begin
        days <= 1;
        months <= 1;
        years <= 0;
        set_button_last <= 1;
	end 
	else begin
		if (~set_button && set_button_last) begin
			case (state) 
				SET_DAY: begin
					days <= days + 1;
					if ((months == 4 || months == 6 || months == 9 || months == 11) && days == 31) begin
						days <= 1;
					end
					else if (months == 2 && years[1:0] == 2'b00 && days == 30) begin
						days <= 1;
					end
					else if (months == 2 && days == 29) begin
						days <= 1;
					end
					else if (days == 32) begin
						days <= 1;
					end
				end
				SET_MONTH: begin
					months <= months + 1;
					if (months == mon_max + 1) begin
						months <= 1;
					end
				end
				SET_YEAR: begin
					years <= years + 1;
					if (years == year_max) begin
						years <= 1;
					end
				end
			endcase
		end
		else if (set_button && ~set_button_last) begin
			set_button_last <= 1;
		end
		else if (~set_button) begin
			set_button_last <= 0;
		end
		else begin
			if (hours == hour_max) begin
				days <= days + 1;
			end
			if ((months == 4 || months == 6 || months == 9 || months == 11) && days == 31) begin
				months <= months + 1;
				days <= 1;
			end
			else if (months == 2 && years[1:0] == 2'b00 && days == 30) begin  // nam nhuan
				months <= months + 1;
				days <= 1;
			end
			else if (months == 2 && years[1:0] != 2'b00 && days == 29) begin
				months <= months + 1;
				days <= 1;
			end
			else if (days == 32) begin
				months <= months + 1;
				days <= 1;
			end	
			if (months == 13) begin
				years <= years + 1;
				months <= 1;
			end
		end
	end	
end

endmodule

`timescale 1ns/1ns
module date_tb();
parameter hour_num = 5;
parameter day_num = 6;
parameter mon_num = 4;
parameter year_num = 7;
parameter state_num = 8;

reg clk_1Hz;
reg rst_n;
reg [$clog2(state_num)-1:0] state;
reg set_button;
reg [hour_num-1:0] hours;
wire [day_num-1:0] days;
wire [mon_num-1:0] months;
wire [year_num-1:0] years;

date uut(.clk_1Hz(clk_1Hz),
	 .rst_n(rst_n),
	 .state(state),
	 .set_button(set_button),
	 .hours(hours),
	 .days(days),
	 .months(months),
	 .years(years)
	);

initial begin
	clk_1Hz = 0;
	forever clk_1Hz = #10 ~clk_1Hz;
end

initial $monitor("time=%t, rst_n=%d, state=%d, set_button=%d, hours=%d, days=%d, months=%d, years=%d", $time, rst_n, state, set_button, hours, days, months, years);
	
initial begin
	rst_n = 1;
	state = 1;
	set_button = 1;
	hours = 10;
	# 20 hours = 15;
	# 20 hours = 22; 
	# 20 hours = 23; 
	# 20 hours = 24; 
	#10000 $finish;
end

endmodule