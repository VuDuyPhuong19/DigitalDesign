module half_adder(
	input [3:0] a,b,
	output c_out,
	output [3:0] s
);

assign {c_out, s} = a + b;

endmodule 