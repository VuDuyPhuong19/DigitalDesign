module century_clock #(
	parameter led_num = 8,
	parameter segment_num = 7
)(
	input clk_50MHz,
	input rst_n,
	input state_button,
	input set_button,
	output reg [led_num*segment_num-1:0] led
);

localparam TIME_VIEW = 0, SET_HOUR = 1, SET_MINUTE = 2, SET_SECOND = 3, DATE_VIEW = 4, SET_DAY = 5, SET_MONTH = 6, SET_YEAR= 7;  

parameter state_num = 8;
parameter n = 4;
// time parameter 
parameter sec_num = 6;
parameter min_num = 6;
parameter hour_num = 5;
// date parameter
parameter day_num = 6;
parameter mon_num = 4;
parameter year_num = 7;

wire clk_1Hz;
// time
wire [sec_num-1:0] seconds;
wire [min_num-1:0] minutes;
wire [hour_num-1:0] hours;
// date
wire [day_num-1:0] days;
wire [mon_num-1:0] months;
wire [year_num-1:0] years;

wire [n-1:0] sec_tens, sec_ones;
wire [n-1:0] min_tens, min_ones;
wire [n-1:0] hour_tens, hour_ones;

wire [n-1:0] day_tens, day_ones;
wire [n-1:0] mon_tens, mon_ones;
wire [n-1:0] year_tens, year_ones;

reg [n*led_num-1:0] led_value;
wire [segment_num-1:0] led_out [led_num-1:0]; // 8 LEDs array

reg [$clog2(state_num)-1:0] state;

initial begin
	state = 0;
end

always @ (negedge state_button) begin
	state = state + 1;
	if (state == state_num) state = 0; 
end
/*
always @ (negedge set_button) begin
	case (state) 
		SET_HOUR: begin
			hours = hours + 1;
			if (hours == hour_max) begin
				hours = 0;
			end
		end
		SET_MINUTE: begin
			minutes = minutes + 1;
			if (minutes == minute_max) begin
				minutes = 0;
			end
		end
		SET_SECOND: begin
			seconds = seconds + 1;
			if (seconds == second_max) begin
				seconds = 0;
			end	
		end
		SET_DAY: begin
			days = days + 1;
			if ((months == 4 || months == 6 || months == 9 || months == 11) && days == 31) begin
				days = 1;
			end
			else if (months == 2 && (((years % 4 == 0) && (years % 100 != 0)) || (years % 400 == 0)) && days == 30) begin
				days = 1;
			end
			else if (months == 2 && days == 29) begin
				days = 1;
			end
			else if (days == 32) begin
				days = 1;
			end
		end
		SET_MONTH: begin
			months = months + 1;
			if (months == mon_max + 1) begin
				months = 1;
			end
		end
		SET_YEAR: begin
			years = years + 1;
			if (years == year_max) begin
				years = 1;
			end
		end
	endcase
end
*/
one_second_pulse one_second_pulse(
	.clk_50MHz(clk_50MHz),
	.rst_n(rst_n),
	.clk_1Hz(clk_1Hz)
);
// convert seconds to BCD
bcd bcd_sec(
	.value(seconds),
	.tens(sec_tens),
	.ones(sec_ones)
);
// convert minutes to BCD
bcd bcd_min(
	.value(minutes),
	.tens(min_tens),
	.ones(min_ones)
);
// convert hours to BCD
bcd bcd_hour(
	.value(hours),
	.tens(hour_tens),
	.ones(hour_ones)
);
// convert days to BCD
bcd bcd_day(
	.value(days),
	.tens(day_tens),
	.ones(day_ones)
);
// convert months to BCD
bcd bcd_mon(
	.value(months),
	.tens(mon_tens),
	.ones(mon_ones)
);
// convert years to BCD
bcd bcd_year(
	.value(years),
	.tens(year_tens),
	.ones(year_ones)
);

always @ (posedge clk_1Hz or negedge rst_n or negedge set_button) begin
	case (state) 
		TIME_VIEW, SET_HOUR, SET_MINUTE, SET_SECOND: begin
			led_value <= {hour_tens, hour_ones, min_tens, min_ones, sec_tens, sec_ones, 4'd10, 4'd10};
			led <= {led_out[7], led_out[6], led_out[5], led_out[4], led_out[3], led_out[2], led_out[1], led_out[0]};
		end
		DATE_VIEW, SET_DAY, SET_MONTH, SET_YEAR: begin
			led_value <= {day_tens, day_ones, mon_tens, mon_ones, 4'd2, 4'd0, year_tens, year_ones};
			led <= {led_out[7], led_out[6], led_out[5], led_out[4], led_out[3], led_out[2], led_out[1], led_out[0]};
		end
	endcase
end

count_24_hours count_24_hours(
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
	.state(state),
	.set_button(set_button),
	.seconds(seconds),
	.minutes(minutes),
	.hours(hours)
);

date date(
	.clk_1Hz(clk_1Hz),
	.rst_n(rst_n),
	.state(state),
	.set_button(set_button),
	.hours(hours),
	.days(days),
	.months(months),
	.years(years)
);

display display(
	.led_value0(led_value[3:0]),
	.led_value1(led_value[7:4]),
	.led_value2(led_value[11:8]),
	.led_value3(led_value[15:12]),
	.led_value4(led_value[19:16]),
	.led_value5(led_value[23:20]),
	.led_value6(led_value[27:24]),
	.led_value7(led_value[31:28]),
	.led_out0(led_out[0]),
	.led_out1(led_out[1]),
	.led_out2(led_out[2]),
	.led_out3(led_out[3]),
	.led_out4(led_out[4]),
	.led_out5(led_out[5]),
	.led_out6(led_out[6]),
	.led_out7(led_out[7])
);

endmodule