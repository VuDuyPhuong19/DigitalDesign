module if_nested(
	input a, b,
	input [1:0] s,
	output reg c
);

always @ (a or b or s)
	begin		 
		if (s == 2'b00) 
			c = a + b;
		
		else if (s == 2'b01) 
			c = a - b;

		else if (s == 2'b10) 
			c = a * b;

		else
			c = ~a;
	end
endmodule