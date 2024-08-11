module control_unit #(
    parameter RESULTSRC_WIDTH = 2,
    parameter ALUCONTROL_WIDTH = 4,
    parameter IMMSRC_WIDTH = 2,
    parameter OPCODE_WIDTH = 7,
    parameter FUNCT7_WIDTH = 7,
    parameter FUNCT3_WIDTH = 3
)(
    input  [OPCODE_WIDTH-1:0] opcode,
    input  [FUNCT7_WIDTH-1:0] funct7,
    input  [FUNCT3_WIDTH-1:0] funct3,
	// input zero,
    output RegWrite_D,
    output [RESULTSRC_WIDTH-1:0] ResultSrc_D,
    output MemWrite_D,
    output Jump_D,
    output Branch_D,
    output [ALUCONTROL_WIDTH-1:0] ALUControl_D,
    output ALUSrc_D,
    output [IMMSRC_WIDTH-1:0] ImmSrc_D
    // output PCSrc
);
wire [1:0] ALUOp;

main_decoder main_decoder(
    .opcode(opcode),
    .ImmSrc(ImmSrc_D),
    .ALUSrc(ALUSrc_D),
    .MemWrite(MemWrite_D),
    .ResultSrc(ResultSrc_D),
    .Branch(Branch_D),
    .Jump(Jump_D),
    .ALUOp(ALUOp),
    .RegWrite(RegWrite_D)
);

ALU_decoder alu_decoder(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl_D)
);
// assign PCSrc = (zero & Branch) | Jump;
endmodule