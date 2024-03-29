module Led(
 input [3:0] number,
 output reg [6:0] hex
);
 always@(number) begin
	case(number)
		4'd0: hex<=7'b0000001;
		4'd1:	hex<=7'b1001111;
		4'd2: hex<=7'b0010010;
		4'd3: hex<=7'b0000110;
		4'd4: hex<=7'b1001100;
		4'd5: hex<=7'b0100100;
		4'd6: hex<=7'b0100000;
		4'd7: hex<=7'b0001111;
		4'd8: hex<=7'b0000000;
		4'd9: hex<=7'b0000100;
	endcase
end
endmodule