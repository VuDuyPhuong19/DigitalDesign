module traffic_light(
	input clk,
	input reset,
	input car,
	output  [6:0] seg_light_h,  // hex0 - 0-green; 1- yellow; 2- red
	output  [6:0] seg_light_r,  // hex1 - 0-green; 1- yellow; 2- red
	output  [6:0] seg_unit,     // hex3
	output  [6:0] seg_ten       // hex4
);

wire time_out_signal, T_out_signal;
wire enable_h, enable_r;
wire one_hz_signal;
wire start_h, start_r, start;
wire [5:0] value;
wire [2:0]light_h, light_r;
wire car_signal;


Debounce DB(
.clk(clk),
.reset(reset),
.D(car),
.Qout(car_signal)
);

hightway_controller HW (
	.clk(clk),
	.reset(reset),
	.car(car_signal),
	.time_out(time_out_signal),
	.T_out(T_out_signal),
	.enable_h(enable_h),
	.enable_r(enable_r),
	.start_h(start_h),
	.light_h(light_h)
);

countryroad_controller CR (
	.clk(clk),
	.reset(reset),
	.car(car_signal),
	.time_out(time_out_signal),
	.T_out(T_out_signal),
	.enable_h(enable_h),
	.enable_r(enable_r),
	.start_r(start_r),
	.light_r(light_r)
);

one_hz_clock one_Hz (
	.clk(clk),           // Đầu vào xung clock 50Mhz
	.reset(reset),       // Đầu vào reset để khởi động lại clock
	.one_hz(one_hz_signal)  // Xung 1Hz đầu ra
);

assign start = start_h | start_r;


timer T (
	.clk(clk),  
	.clk_1Hz(one_hz_signal),
	.reset(reset),  
	.start(start), 
	.T_out(T_out_signal),
	.time_out(time_out_signal),
	.count(value)
);

lights Led (
	.clk(clk),
	.reset(reset),
	.light_h(light_h),
	.light_r(light_r),
	.value(value),
	.seg_light_h(seg_light_h),
	.seg_light_r(seg_light_r),
	.seg_unit(seg_unit),
	.seg_ten(seg_ten)
);
endmodule
