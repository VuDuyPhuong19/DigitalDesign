module full_adder(
	input [3:0] a,b,
	input c_in,
	output c_out,
	output [3:0] s
);

assign {c_out, s} = a + b + c_in;

endmodule 