module Registers #(
	parameter NUM_REG = 32,
	parameter REG_ADDR_WIDTH = $clog2(NUM_REG)
	parameter REG_WIDTH = 32
)(
	input clk,
	input rst_n,
	input RegWrite,
	input [REG_ADDR_WIDTH-1:0] addr_rs1, addr_rs2, addr_rd,
	input [REG_WIDTH-1:0] data_rd,
	output [REG_WIDTH-1:0] data_rs1, data_rs2
);

reg [REG_WIDTH-1:0] registers [0:NUM_REG-1];

integer i;
alwasy @ (posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		for(i = 0; i < NUM_REG; i++) begin
			registers[i] <= {REG_WIDTH{1'b0}};
		end
	end
	else if (RegWrite) begin
		registers[addr_rd] <= data_rd;
	end
end

assign data_rs1 = registers[addr_rs1];
assign data_rs2 = registers[addr_rs2];

endmodule