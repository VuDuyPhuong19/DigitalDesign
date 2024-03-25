module count_24_hours #(
	parameter led_num = 6,
	parameter segment_num = 7,
	parameter n = 4,	
	parameter sec_num = 6,
	parameter second_max = 60,
	parameter min_num = 6,
	parameter minute_max = 60,
	parameter hour_num = 5,
	parameter hour_max = 24	
)(
	input clk_1Hz,
	input rst_n,
	output reg [led_num*segment_num-1:0] hour_led
);

reg [sec_num-1:0] seconds;
reg [min_num-1:0] minutes;
reg [hour_num-1:0] hours;
wire [n-1:0] sec_tens, sec_ones;
wire [n-1:0] min_tens, min_ones;
wire [n-1:0] hour_tens, hour_ones;
wire [segment_num-1:0] led_out [led_num-1:0]; // 4 LEDs array

bcd bcd_sec(
	.value(seconds),
	.tens(sec_tens),
	.ones(sec_ones)
);

bcd bcd_min(
	.value(minutes),
	.tens(min_tens),
	.ones(min_ones)
);

bcd bcd_hour(
	.value(minutes),
	.tens(hour_tens),
	.ones(hour_ones)
);
	
seven_segment led_0(
	.value(sec_ones),
	.led(led_out[0])
);
seven_segment led_1(
	.value(sec_tens),
	.led(led_out[1])
);
seven_segment led_2(
	.value(min_ones),
	.led(led_out[2])
);

seven_segment led_3(
	.value(min_tens),
	.led(led_out[3])
);

seven_segment led_4(
	.value(hour_ones),
	.led(led_out[4])
);

seven_segment led_5(
	.value(hour_tens),
	.led(led_out[5])
);

initial begin
	seconds = 0;
	minutes = 0;
	hours = 0;
end

always @ (posedge clk_1Hz or negedge rst_n) begin
	if (~rst_n) begin
		seconds <= 0;
		minutes <= 0;
		hours <= 0;
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
		if (hours == hour_max - 1) begin
			hours <= 0;
		end
	end
end

always @ (*) begin
	hour_led = {led_out[5], led_out[4], led_out[3], led_out[2], led_out[1], led_out[0]};
end


endmodule