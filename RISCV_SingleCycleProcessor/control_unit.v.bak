module control_unit(
    input wire [6:0] opcode,
    input wire [6:0] funct7,
    input wire[2:0] funct3,
	 input zero,
    output RegWrite,
    output wire [1:0] ImmSrc,
	 output wire ALUSrc,
	 output wire Memwrite,
	 output wire ResultSrc,
    output wire [2:0] ALUControl,
    output wire PCSrc
);
wire [1:0] ALUOp;
wire Branch;
Main_decoder main(
    .opcode(opcode),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .Memwrite(Memwrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .ALUOp(ALUOp),
    .RegWrite(RegWrite)
);
ALU_decoder decode_1(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl)
);
assign PCSrc=zero&Branch;
endmodule