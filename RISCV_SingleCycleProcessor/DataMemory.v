module DataMemory #(
	parameter ADDR_WIDTH = 32,
	parameter DMEM_WIDTH = 32,
	parameter DMEM_DEPTH = 1 << 32
)(
	input clk, 
	input rst_n,
	input MemWrite,
	input [ADDR_WIDTH-1:0] addr,
	input [DMEM_WIDTH-1:0] write_data,
	output [DMEM_WIDTH-1:0] read_data
);

reg [DMEM_WIDTH-1:0] dmem [DMEM_DEPTH-1:0];

assign read_data = dmem[addr];

integer i;
always @ (posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		for (i = 0; i < DMEM_DEPTH; i = i + 1) begin
			dmem[i] <= 32'b0;
		end
	end
	else if (MemWrite) begin
		dmem[addr] = write_data;
	end
end

endmodule