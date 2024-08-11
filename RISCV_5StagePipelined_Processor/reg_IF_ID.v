module reg_IF_ID #(
	parameter INST_WIDTH = 32,
	parameter PC_WIDTH = 32
)(
	input clk, 
	input rst_n,
	input Stall_D,
	input [INST_WIDTH-1:0] inst_F,
	input [PC_WIDTH-1:0] PCplus4_F,
	input [PC_WIDTH-1:0] PC_F,
	input Flush_D,
	output reg [INST_WIDTH-1:0] inst_D,
	output reg [PC_WIDTH-1:0] PCplus4_D,
	output reg [PC_WIDTH-1:0] PC_D
);

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		inst_D <= 0;
		PCplus4_D <= 0;
		PC_D <= 0;
	end
	else begin
		if (!Stall_D) begin
			if (Flush_D) begin
				inst_D <= 0;
				PCplus4_D <= 0;
				PC_D <= 0;
			end
			else begin
				inst_D <= inst_F;
				PCplus4_D <= PCplus4_F;
				PC_D <= PC_F;
			end
		end
	end
end

endmodule 