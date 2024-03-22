module majority(
	input[7:0] a,
	output reg b
);
parameter n=8;
integer i;
reg [3:0]cnt;
always @(a)
begin
  cnt=0;
	for(i=0;i<n;i=i+1)
		begin
			if(a[i]) cnt=cnt+1;
			else cnt=cnt;
		end
		b=(cnt>=n/2)?1:0;
end
endmodule
`timescale 1ns/1ps
module test_bench_mojority();
reg [7:0]a_t;
wire b_t;
majority maj(
  .a(a_t),
  .b(b_t)
);
initial 
  begin
    a_t=8'b01010000;
    #10
    a_t=8'b00110101;
    #10;
  end
endmodule
