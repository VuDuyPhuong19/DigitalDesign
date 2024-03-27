module one_second_pulse(
	input clk_50MHz, // Clock input (50MHz)
	input rst_n,
	output reg clk_1Hz
);

parameter COUNTER_MAX = 50000000;

reg [25:0] counter;

always @ (posedge clk_50MHz or negedge rst_n) begin
	if (!rst_n) begin
		counter <= 26'b0;
		clk_1Hz <= 1'b0;
	end
	else begin
		if(counter == COUNTER_MAX - 1) begin
			counter <= 26'b0;
			clk_1Hz <= 1'b1;
		end
		else begin
			counter <= counter + 26'b1;
			clk_1Hz <= 1'b0;
		end
	end
end

endmodule