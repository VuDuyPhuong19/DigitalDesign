module one_hz_clock(
	input clk, //đầu vào xung clock 50Mhz
	input reset, // đầu vào reset để khởi động lại clock
	output reg one_hz  // xung 1Hz đầu ra
);

// tần số của clock là 50Mhz

parameter CLOCK_FREQ = 50_000_000;
parameter COUNTER_MAX = CLOCK_FREQ/2-1;
reg [25:0] counter; // 26bit ~ 49_999_999

always @(posedge clk or negedge reset) begin
	if(~reset) begin
		counter <=0;
		one_hz <=0;
	end else begin
	if ( counter == COUNTER_MAX ) begin
		counter <=0;
		one_hz <= ~one_hz; // sau 1s one_hz được gán bằng 1
	end 
	else  counter <= counter + 1; // Tăng bộ đếm
	end

	end
endmodule