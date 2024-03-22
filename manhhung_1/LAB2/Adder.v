module adder(
	input[3:0] a,b,
	output [3:0]s,
	output c);
	assign {w,s}=a+b;
endmodule
`timescale 1ns/1ps
module testbench_adder();
	reg[3:0] stim_a,stim_b;
	wire [3:0] mon_s;
	wire mon_c;
	adder adder_duv(
	.a(stim_a),
	.b(stim_b),
	.s(mon_s),
	.c(mon_c)
);
initial
begin 
	stim_a=0;
	stim_b=1;
	#5;
	stim_a=10;
	stim_b=15;
	#5;
//	$monitor("%d%d",stim_a,sim_b);
end
endmodule