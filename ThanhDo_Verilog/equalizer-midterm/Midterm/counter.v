module counter (
	input clk,
	input rst_n,
	output reg [4:0] count,
	output calculated
);

parameter COUNTER_MIN = 5'b00000;
parameter COUNTER_MAX = 5'b11110;
always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		count <= 0;
	end
	else begin
		if (count == COUNTER_MAX) begin
			count <= COUNTER_MIN;
		end
		else begin
			count <= count + 1;
		end
	end
end

assign calculated = (count == COUNTER_MIN) ? 1 : 0;

endmodule