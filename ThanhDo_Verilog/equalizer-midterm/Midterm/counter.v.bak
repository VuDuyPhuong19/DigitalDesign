module counter (
	input clk,
	input rst_n,
	output reg [4:0] counter,
	output calculated
);

parameter COUNTER_MIN = 5'000000;
parameter COUNTER_MAX = 5'b11111;

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		counter <= 0;
	end
	else begin
		if (counter == COUNTER_MAX) begin
			counter <= COUNTER_MIN;
		end
		else begin
			counter <= counter + 1;
		end
	end
end

assign calculated = (counter == COUNTER_MAX) ? 1 : 0;

endmodule