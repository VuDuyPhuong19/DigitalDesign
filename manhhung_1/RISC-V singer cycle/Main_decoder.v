module Main_decoder(
	input [6:0] opcode,
	output reg RegWrite,
	output reg [1:0] ImmSrc,
	output reg ALUSrc,
	output reg Memwrite,
	output reg ResultSrc,
	output reg Branch,
	output reg [1:0] ALUOp
);
always@(opcode) begin
case(opcode)
	7'b 0110011: begin //R-type
		 RegWrite=1;
		 ALUSrc=0;
		 Memwrite=0;
		 ResultSrc=0;
		 Branch=0;
		 ALUOp=2'b 10;
	end
	7'b 0010011: begin //I-type add
		RegWrite=1;
		ImmSrc=2'b 00;
		ALUSrc=1;
		Memwrite=0;
		ResultSrc=0;
		Branch=0;
		ALUOp=2'b 01;
	end
	7'b 0000011: begin //I-type load
		RegWrite=1;
		ImmSrc=2'b 00;
		ALUSrc=1;
		Memwrite=0;
		ResultSrc=1;
		Branch=0;
		ALUOp=2'b 00;
	end
	7'b 0100011: begin
		RegWrite=0;
		ImmSrc=2'b 01;
		ALUSrc=1;
		Memwrite=1;
		Branch=0;
		ALUOp=2'b 00;
	end
	7'b 1100011: begin //B-type
		RegWrite=0;
		ImmSrc=2'b 10;
		ALUSrc=0;
		Memwrite=0;
		Branch=1;
		ALUOp=2'b 11;
	end
	7'b 1101111: begin //J-type
		RegWrite=0;
		ImmSrc=2'b 10;
		ALUSrc=0;
		Memwrite=0;
		Branch=1;
		ALUOp=2'b 10;
	end
  /*7'b 0110111: begin
	end
	7'b 0010111:
	7'b 1110011: */
endcase
end
endmodule