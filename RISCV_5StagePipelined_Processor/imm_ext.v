module imm_ext #(
	parameter INST_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter FUNCT3_WIDTH = 3
)(
	input [INST_WIDTH-1:0] Instruction,
	// input  [FUNCT3_WIDTH-1:0] funct3,
	output reg [IMM_WIDTH-1:0] ImmExt_D
);

always @(*) begin
	case(Instruction[6:0]) 
		// I type
		7'b0010011: begin 
			// sll, srl, sra
			// if (funct3 == 3'b101 || funct3 == 3'b001) begin 
			// 	ImmExt_D = {{27{Instruction[24]}}, Instruction[24:20]};
			// end
			// else begin
				ImmExt_D = {{20{Instruction[31]}}, Instruction[31:20]};
			// end
		end
		// L type
		7'b0000011: ImmExt_D = {{20{Instruction[31]}}, Instruction[31:20]};
		// S type
		7'b0100011: ImmExt_D = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
		// B type
		7'b1100011: ImmExt_D = {{20{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]};
		// J type
		7'b1101111: ImmExt_D = {{12{Instruction[31]}}, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21]};
		// JALR type
		7'b1100111: ImmExt_D = {{20{Instruction[31]}}, Instruction[31:20]};
        // LUI type
        7'b0110111: ImmExt_D = {Instruction[31:12], 12'b0}; // LUI
        // AUIPC type
        7'b0010111: ImmExt_D = {Instruction[31:12], 12'b0}; // AUIPC

		default: ImmExt_D = 32'b0;
	endcase	
end

endmodule