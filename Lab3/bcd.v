module bcd #(parameter n = 6)(
	input [n-1:0] value,
	output reg [3:0] tens,
	output reg [3:0] ones
);

always @ (value) begin
	tens = value / 10;
	ones = value % 10;
end

endmodule