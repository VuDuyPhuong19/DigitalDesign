module LAB2(
	input [7:0] a,b,
	input s1,s2,
	output reg [7:0] y
);
always@(a or b or s1 or s2)
begin 
	casez ({s1,s2})
	    2'b00: y=a+b;
		 2'b01: y=a-b;
		 2'b10: y=a*b;
		 2'b11: y=~a;
		 default: y=~a;
	endcase
end
endmodule
