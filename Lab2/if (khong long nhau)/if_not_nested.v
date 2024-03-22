module if_not_nested(
	input a, b,
	input [1:0] s,
	output reg c
);

always @ (a or b or s)
	begin
	
		c = 1; 
		 
		if (s == 2'b00) 
			c = a + b;
		
		if (s == 2'b01) 
			c = a - b;

		if (s == 2'b10) 
			c = a * b;

		if (s == 2'b11)
			c = ~a;
	end
endmodule