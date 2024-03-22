module Full_Adder(
	input a,b,
	input cin,
	output s,
	output cout
);
assign s=a ^ b ^ cin;
assign cout=(a ^ b)& cin | (a & b);
endmodule
module add_4_bit(
	input [3:0] a,b,
	input cin_,
	output [3:0] s1,
	output cout_
);
	wire [3:0]im_c;
	Full_Adder add(
			.a(a[0]),
			.b(b[0]),
			.cin(cin_),
			.s(s1[0]),
			.cout(im_c[0])
		);
genvar i;
generate
	for(i=1;i<4;i=i+1) begin :hehe
			Full_Adder add1(
			.a(a[i]),
			.b(b[i]),
			.cin(im_c[i-1]),
			.s(s1[i]),
			.cout(im_c[i])
		);
		end
endgenerate
assign	cout_=im_c[3];
endmodule
`timescale 1ns/1ps
module test_bench_add_4();
reg [3:0]stima,stimb;
reg cin_t;
wire [3:0] s_t;
wire cout_t;
add_4_bit adder(
	.a(stima),
	.b(stimb),
	.cin_(cin_t),
	.s1(s_t),
	.cout_(cout_t)
);
initial 
begin 
		stima=4'b0100;
		stimb=4'b0111;
		cin_t=0;
		#10
		stima=4'b1010;
		stimb=4'b1010;
		cin_t=0;
		#10;
end
endmodule