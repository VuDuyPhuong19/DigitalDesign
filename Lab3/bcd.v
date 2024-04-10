module bcd #(parameter n = 6)(
	input [n-1:0] value,
	output reg [3:0] tens,
	output reg [3:0] ones
);

integer i;

always @ (value) begin
    tens = 0;
    ones = 0;
    for (i = 0; i <= n - 1; i = i + 1) begin
    	tens = {tens[2:0], ones[3]};
    	ones = {ones[2:0], value[n - 1 -i]};	
    	if (ones >= 10) begin
    		ones = ones - 10;
    		tens = tens + 1;
    	end
    end
end

endmodule

module bcd_tb();
parameter n = 6;
reg [n-1:0] stim_value;
wire [3:0] ones;
wire [3:0] tens;
bcd uut(.value(stim_value), .tens(tens), .ones(ones));

initial $monitor("time=%t, stim_value=%d, tens=%d, ones=%d", $time, stim_value, tens, ones);

initial begin
	stim_value = 10;
	#20 stim_value = 15;
end

endmodule
