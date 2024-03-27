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

initial begin
	days = 1;
	months = 1;
	years = 0;
end

always @ (posedge clk_1Hz or negedge rst_n or negedge set_button) begin
	if (~rst_n) begin
        days <= 1;
        months <= 1;
        years <= 0;
	end 
	else if (~set_button) begin
		case (state) 
			SET_DAY: begin
				days <= days + 1;
				if ((months == 4 || months == 6 || months == 9 || months == 11) && days == 31) begin
					days <= 1;
				end
				else if (months == 2 && (((years % 4 == 0) && (years % 100 != 0)) || (years % 400 == 0)) && days == 30) begin
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
	else begin
		if (hours == hour_max) begin
			days <= days + 1;
		end
		if ((months == 4 || months == 6 || months == 9 || months == 11) && days == 31) begin
			months <= months + 1;
			days <= 1;
		end
		else if (months == 2 && (((years % 4 == 0) && (years % 100 != 0)) || (years % 400 == 0)) && days == 30) begin  // nam nhuan
			months <= months + 1;
			days <= 1;
		end
		else if (months == 2 && days == 29) begin
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

endmodule