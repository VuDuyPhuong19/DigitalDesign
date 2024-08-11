module hazard_unit #(
	parameter REG_ADDR_WIDTH = 5,
	parameter RESULTSRC_WIDTH = 2
)(
	input [REG_ADDR_WIDTH-1:0] rd_W,
	input [REG_ADDR_WIDTH-1:0] rd_M,
	input [REG_ADDR_WIDTH-1:0] rd_E,
	input [REG_ADDR_WIDTH-1:0] rs1_E, 
	input [REG_ADDR_WIDTH-1:0] rs2_E,
	input [REG_ADDR_WIDTH-1:0] rs1_D, 
	input [REG_ADDR_WIDTH-1:0] rs2_D,
	input RegWrite_M,
	input RegWrite_W,
	input [RESULTSRC_WIDTH-1:0] ResultSrc_E,
	input PCSrc_E,
	output reg [1:0] ForwardA_E,
	output reg [1:0] ForwardB_E,
	output Stall_F,
	output Stall_D,
	output Flush_D,
	output Flush_E
);

wire lwStall;

// Stalling
assign lwStall = ((rs1_D == rd_E) || (rs2_D == rd_E)) && (ResultSrc_E == 2'b01); // ResultSrc_E = 2'b01 corresponds to lw instruction

assign Stall_F = lwStall;
assign Stall_D = lwStall;


// assign Flush_E = lwStall | PCSrc_E;
assign Flush_E = PCSrc_E;
assign Flush_D = PCSrc_E;


// Data forwarding 

always @ (*) begin

	// Forwarding logic for A
	if ((rs1_E == rd_M) && RegWrite_M && (rs1_E != 0)) begin // Forward from Memory Stage
		ForwardA_E = 2'b10;
	end
	else if ((rs1_E == rd_W) && RegWrite_W && (rs1_E != 0)) begin // Forward from Writeback Stage
		ForwardA_E = 2'b01;
	end
	else begin
		ForwardA_E = 2'b00;
	end

	// if ((rs1_E == rd_W) && RegWrite_W && (rs1_E != 0)) begin // Forward from Writeback Stage
	// 	ForwardA_E = 2'b01;
	// end
	// else if ((rs1_E == rd_M) && RegWrite_M && (rs1_E != 0)) begin // Forward from Memory Stage
	// 	ForwardA_E = 2'b10;
	// end
	// else begin
	// 	ForwardA_E = 2'b00;
	// end

	// Forwarding logic for B
	if ((rs2_E == rd_M) && RegWrite_M && (rs2_E != 0)) begin // Forward from Memory Stage
		ForwardB_E = 2'b10;
	end
	else if ((rs2_E == rd_W) && RegWrite_W && (rs2_E != 0)) begin // Forward from Writeback Stage
		ForwardB_E = 2'b01;
	end
	else begin
		ForwardB_E = 2'b00;
	end
end





endmodule 