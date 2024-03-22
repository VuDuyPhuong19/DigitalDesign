module ALU( 
	input [3:0] A,B, // đầu vào bit
	input control,   // 0 cộng, 1 trừ
	output reg [4:0] result
);

always @(A,B,control) 
begin
		if( control==0)
			result=A+B; // cộng
		else 
			result=A-B;


end
endmodule