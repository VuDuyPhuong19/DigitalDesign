module reg_file #(
	parameter NUM_REG = 32,
	parameter REG_ADDR_WIDTH = 5,
	parameter REG_WIDTH = 32
)(
	input clk,
	input rst_n,
	input RegWrite,
	input [REG_ADDR_WIDTH-1:0] addr_rs1, 
	input [REG_ADDR_WIDTH-1:0] addr_rs2,
	input [REG_ADDR_WIDTH-1:0] addr_rd,
	input [REG_WIDTH-1:0] data_rd,
	output reg [REG_WIDTH-1:0] data_rs1, 
	output reg [REG_WIDTH-1:0] data_rs2
);

reg [REG_WIDTH-1:0] registers [0:NUM_REG-1];

// initial begin
// 	registers[1] = 1;
// 	registers[2] = 2;
// 	registers[3] = 3;
// 	registers[4] = 4;
// 	registers[5] = 5;
// end

//============================================
// 	Write to Register File (posedge of clk)
//============================================

integer i;
always @ (negedge clk or negedge rst_n) begin
	if(~rst_n) begin
		registers[0] <= 0;
		registers[1] <= 1;
		registers[2] <= 2;
		registers[3] <= 3;
		registers[4] <= 4;
		registers[5] <= 5;
		for(i = 6; i < NUM_REG; i = i + 1) begin
			registers[i] <= {REG_WIDTH{1'b0}};
		end
	end
	else if (RegWrite) begin
    if (addr_rd != 0) begin // x0 register always equal 0
        registers[addr_rd] <= data_rd;
    end
	end
end

//============================================
//  Read from Register File (negedge of clk)
//============================================

  // always @(negedge clk) begin
  //     data_rs1 <= registers[addr_rs1];
  //     data_rs2 <= registers[addr_rs2];
  // end

always @ (addr_rs1 or addr_rs2) begin
		data_rs1 = registers[addr_rs1];
		data_rs2 = registers[addr_rs2];
end

// assign data_rs1 = registers[addr_rs1];
// assign data_rs2 = registers[addr_rs2];

endmodule