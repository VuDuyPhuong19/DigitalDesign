module clk_1s(
	input clk,
	input rst_n,
	output reg clk_1s_enable
);

reg [25:0] counter;
// parameter COUNTER_MAX = 50000000;
parameter COUNTER_MAX = 10; 

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		counter <= 26'b0;
		clk_1s_enable <= 1'b0;
	end
	else begin
		if (counter == COUNTER_MAX - 1) begin
			counter <= 26'b0;
			clk_1s_enable <= 1;
		end
		else begin
			counter <= counter + 1;
			clk_1s_enable <= 0;
		end
	end

end

endmodule 