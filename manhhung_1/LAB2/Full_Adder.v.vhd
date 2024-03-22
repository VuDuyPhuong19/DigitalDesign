module Full_Adder(
	input a,b,
	input cin;
	output s,
	output cout
);
assign s=a XOR b XOR cin;
assign cout=(a XOR b)AND cin OR (a AND b);
endmodule
module add_4_bit(
	input [3:0] a,b,
	input cin,
	output [3:0],
	output cout
);
