module count_60s #(
	parameter led_num = 2,
	parameter n = 4,
	parameter sec_num = 6,
	parameter second_max = 60,
	parameter segment_num = 7
)
(
	input clk_1Hz,
	input rst_n,
	output reg [led_num*segment_num-1:0] second_led
);

reg [sec_num-1:0] seconds;
wire [n-1:0] sec_tens, sec_ones;
wire [segment_num-1:0] led_out [led_num-1:0]; // 2 LEDs array

bcd bcd(
	.value(seconds),
	.tens(sec_tens),
	.ones(sec_ones)
);

seven_segment led_0(
	.value(sec_ones),
	.led(led_out[0])
);
seven_segment led_1(
	.value(sec_tens),
	.led(led_out[1])
);

initial begin
	seconds = 0;
end

always @ (posedge clk_1Hz or negedge rst_n) begin
	if (~rst_n) begin
		seconds <= 0;
	end
	else begin
		seconds <= seconds + 1;
		if (seconds == second_max - 1) begin 
			seconds <= 0;
		end		
	end
end

always @ (*) begin
	second_led = {led_out[1], led_out[0]};
end

endmodule 