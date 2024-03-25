module seven_segment #(
	parameter segment_num = 7,
	parameter n = 4
)(
	input [n-1:0] value, 
	output reg [segment_num-1:0] led 
);

always @ (value) begin
	case(value)
		0: led = 7'b0000001;
		1: led = 7'b1001111;
		2: led = 7'b0010010;
		3: led = 7'b0000110;
		4: led = 7'b1001100;
		5: led = 7'b0100100;
		6: led = 7'b0100000;
		7: led = 7'b0001111;
		8: led = 7'b0000000;
		9: led = 7'b0000100;
		default: led = 7'b1111111;
	endcase
end

endmodule