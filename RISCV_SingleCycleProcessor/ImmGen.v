module ImmGen #(
	parameter INST_WIDTH = 32,
	parameter IMM_WIDTH = 32
)(
	input [INST_WIDTH-1:0] Instruction,
	output reg [IMM_WIDTH-1:0] ImmExt
);

always @(*) begin
	case(Instruction[6:0]) 
		// I type
		7'b0010011: ImmExt = {{20{Instruction[31]}}, Instruction[31:20]};
		// L type
		7'b0000011: ImmExt = {{20{Instruction[31]}}, Instruction[31:20]};
		// S type
		7'b0100011: ImmExt = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
		// B type
		7'b1100011: ImmExt = {{20{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]};
		// J type
		7'b1101111: ImmExt = {{12{Instruction[31]}}, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21]};
		default: ImmExt = 32'b0;
	endcase	
end

endmodule