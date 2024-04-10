module case_test (
	input [9:0] reset_potential,
	input reset_mode,
	input [9:0] leak_potential,
	input [9:0] positive_threshold,
	input [9:0] negative_threshold,
	output reg [9:0] positive_reset_value,
	output reg [9:0] negative_reset_value
);

always @ (*) begin
	case (reset_mode) 
		0: begin
			 positive_reset_value = reset_potential;
			 negative_reset_value = -reset_potential;
		end
		// Linear reset
		1: begin
			 positive_reset_value = leak_potential - positive_threshold;
			 negative_reset_value = leak_potential - negative_threshold;
		end
		default: begin
			 positive_reset_value = 0;
			 negative_reset_value = 0;
		end
		endcase
end

endmodule