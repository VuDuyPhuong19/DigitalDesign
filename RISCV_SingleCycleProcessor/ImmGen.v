module ImmGen #(
	parameter INST_WIDTH = 32,
	parameter IMM_WIDTH = 32
)(
	input [INST_WIDTH-1:0] instruction,
	output [IMM_WIDTH-1:0] ImmExt
);

always @(*) begin
	case(instruction[6:0]) 
		// I type
		7'b0010011: ImmExt = {{20{instruction[31]}}, instruction[31:20]};
		// L type
		7'b0000011: ImmExt = {{20{instruction[31]}}, instruction[31:20]};
		// S type
		7'b0100011: ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
		// B type
		7'b1100111: ImmExt = {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
		// J type
		7'b1101111: ImmExt = {{12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21]};
		default: ImmExt = 32'b0;
	endcase	
end

endmodule