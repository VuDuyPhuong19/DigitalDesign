`timescale 1ns / 1ns
module one_second_pulse_tb();

reg stim_clk;
reg stim_rst;
wire mon_pulse;

one_second_pulse uut(
	.clk(stim_clk),
	.rst_n(stim_rst),
	.pulse(mon_pulse)
);

initial begin
	stim_clk = 0;
	stim_rst = 0;
	#100
	stim_rst = 1;
end 

always #10 stim_clk = ~ stim_clk;

endmodule