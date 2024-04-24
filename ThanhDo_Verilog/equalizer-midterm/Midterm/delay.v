module delay #(
	parameter DATA_BIT_NUM = 16,
	parameter NUMTABS = 31
)(
	input clk,
	input rst_n,
	input count,
	input calculated,
	input signed [DATA_BIT_NUM-1:0] data_in,
	output signed [DATA_BIT_NUM-1:0] data_delay_in
);

reg signed [DATA_BIT_NUM-1:0] data_delay [NUMTABS-1:0];
integer i;

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		for (i = 0; i < NUMTABS; i = i + 1) begin
			data_delay[i] <= 0;
		end
	end
	else begin
		if (calculated) begin
			data_delay[0] <= data_in;
			for (i = 1; i < NUMTABS; i = i + 1) begin
				data_delay[i] <= data_delay[i - 1];
			end
		end		
	end
end

assign data_delay_in = data_delay[count];

endmodule