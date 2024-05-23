module control_unit #(
    parameter RESULTSRC_WIDTH = 2,
    parameter ALUCONTROL_WIDTH = 4,
    parameter OPCODE_WIDTH = 7,
    parameter FUNCT7_WIDTH = 7,
    parameter FUNCT3_WIDTH = 3
)(
    input  [OPCODE_WIDTH-1:0] opcode,
    input  [FUNCT7_WIDTH-1:0] funct7,
    input  [FUNCT3_WIDTH-1:0] funct3,
	input zero,
    output RegWrite,
    output [1:0] ImmSrc,
	output ALUSrc,
	output MemWrite,
	output [RESULTSRC_WIDTH-1:0] ResultSrc,
    output [ALUCONTROL_WIDTH-1:0] ALUControl,
    output PCSrc
);
wire [1:0] ALUOp;
wire Branch;
wire Jump;
Main_decoder main_decoder(
    .opcode(opcode),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp),
    .RegWrite(RegWrite)
);
ALU_decoder decode_1(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl)
);
assign PCSrc = (zero & Branch) | Jump;
endmodule