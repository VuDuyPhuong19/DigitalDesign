module exam9_3(
input [7:0] a,b,
input s1,s2, 
output [7:0] y
);
always @(a or b or s1 or s2) 
begin 
	case	{s1,s2}b
		2'b00: y=a+b;
		2'b01: y=a-b;
		2'b10: y=a*b;
		default y= ~a; // not a
	endcase
end 
endmodule 
		
		
		