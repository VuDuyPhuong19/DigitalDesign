module led7(
input [3:0] in_switch,
output reg [6:0] out_led//abcd
);
always @(in_switch) begin 
	case(in_switch) 
		4'b0000: out_led=7'b0000001;
		4'b0001: out_led=7'b1001111;
		4'b0010: out_led=7'b0010010;
		4'b0011: out_led=7'b0000110;
		4'b0100: out_led=7'b1001100;
		4'b0101: out_led=7'b0100100;
		4'b0110: out_led=7'b0100000;
		4'b0111: out_led=7'b0001111;
		4'b1001: out_led=7'b0000100;
		default: out_led=7'b0000000;
	endcase
	end
endmodule