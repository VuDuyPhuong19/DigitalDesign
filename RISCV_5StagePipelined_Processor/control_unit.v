module control_unit #(
    parameter RESULTSRC_WIDTH = 2,
    parameter ALUCONTROL_WIDTH = 6,
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
    output [1:0] ALUSrcA_D,
    output ALUSrcB_D,
    output [IMMSRC_WIDTH-1:0] ImmSrc_D,
    output PCJalSrc_D,
    output [1:0] write_type_D,
    output start_mult_D,
    output start_div_D,
    output [1:0] mult_func_D,
    output [1:0] div_func_D,
    output ALUResultSrc_D
    // output [1:0] calc_result_src_D
    // output PCSrc
);
wire [1:0] ALUOp;

main_decoder main_decoder(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .ImmSrc(ImmSrc_D),
    .ALUSrcB(ALUSrcB_D),
    .ALUSrcA(ALUSrcA_D),
    .MemWrite(MemWrite_D),
    .ResultSrc(ResultSrc_D),
    .Branch(Branch_D),
    .Jump(Jump_D),
    .ALUOp(ALUOp),
    .RegWrite(RegWrite_D),
    .PCJalSrc_D(PCJalSrc_D),
    .write_type_D(write_type_D),
    .start_mult_D(start_mult_D),
    .start_div_D(start_div_D),
    .mult_func_D(mult_func_D),
    .div_func_D(div_func_D),
    .ALUResultSrc_D(ALUResultSrc_D)
    // .calc_result_src_D(calc_result_src_D)
);

ALU_decoder alu_decoder(
    .opcode(opcode),
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl_D)
);
// assign PCSrc = (zero & Branch) | Jump;
endmodule