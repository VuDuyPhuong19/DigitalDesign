module RISCV_SingleCycleProcessor #(
	parameter PC_WIDTH = 32,
	parameter INST_WIDTH = 32,
	parameter NUM_REG = 32,
	parameter REG_ADDR_WIDTH = $clog2(NUM_REG),
	parameter REG_WIDTH = 32,
	parameter IMM_WIDTH = 32,
	parameter ALUCONTROL_WIDTH = 4,
	parameter IMMSRC_WIDTH = 2,
	parameter ALU_RESULT_WIDTH = 32,
	parameter ADDR_WIDTH = 32,
	parameter DMEM_WIDTH = 32,
	parameter RESULTSRC_WIDTH = 2,
	parameter WB_RESULT_WIDTH = 32
)(
	input clk,
	input rst_n
);

// Instruction Fetch
wire [PC_WIDTH-1:0] next_pc;
wire [INST_WIDTH-1:0] Instruction;

// Instruction Decode
wire zero;
wire [REG_WIDTH-1:0] data_rs1, data_rs2;
wire [IMM_WIDTH-1:0] ImmExt;
wire [IMMSRC_WIDTH-1:0] ImmSrc;
wire ALUSrc;
wire MemWrite;
wire [RESULTSRC_WIDTH-1:0] ResultSrc;
wire [ALUCONTROL_WIDTH-1:0] ALUControl;
wire PCSrc;

// Execute/Address calculation
wire [PC_WIDTH-1:0] pc_add_imm;
wire [ALU_RESULT_WIDTH-1:0] ALU_result;

// Memory access
wire [DMEM_WIDTH-1:0] read_data;

// Write back
wire [PC_WIDTH-1:0] pc_add_1;
wire [WB_RESULT_WIDTH-1:0] wb_result;


//------------------------------Instruction Fetch------------------------------//

stage_IF IF(.clk(clk),
		 .rst_n(rst_n),
		 .pc_add_imm(pc_add_imm),
		 .PCSrc(PCSrc),
		 .next_pc(next_pc),
		 .Instruction(Instruction));

//------------------------------Instruction Decode------------------------------// 

stage_ID ID(.clk(clk),
			.rst_n(rst_n),
			.Instruction(Instruction),
			.data_rd(wb_result),
			.zero(zero),
			.data_rs1(data_rs1),
			.data_rs2(data_rs2),
			.ImmExt(ImmExt),
			.ImmSrc(ImmSrc),
			.ALUSrc(ALUSrc),
			.MemWrite(MemWrite),
			.ResultSrc(ResultSrc),
			.ALUControl(ALUControl),
			.PCSrc(PCSrc));

//------------------------------------Execute------------------------------------// 

stage_EX EX(.ImmExt(ImmExt),
			.data_rs1(data_rs1),
			.data_rs2(data_rs2),
			.ALUControl(ALUControl),
			.pc(next_pc),
			.ALUSrc(ALUSrc),
			.zero(zero),
			.ALU_result(ALU_result),
			.pc_add_imm(pc_add_imm));

//---------------------------------Memory Access---------------------------------//  

DataMemory MEM(.clk(clk),
			   .rst_n(rst_n),
			   .MemWrite(MemWrite),
			   .addr(ALU_result),
			   .write_data(data_rs2),
			   .read_data(read_data));

//-----------------------------------Write back-----------------------------------// 

assign pc_add_1 = next_pc + 1;

stage_WB WB(.ResultSrc(ResultSrc),
			.read_data(read_data),
			.ALU_result(ALU_result),
			.pc_add_1(pc_add_1),
			.wb_result(wb_result));


endmodule

module RISCV_SingleCycleProcessor_tb();
reg clk;
reg rst_n;

RISCV_SingleCycleProcessor dut(.clk(clk),
							   .rst_n(rst_n));

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	rst_n = 0;
	#3 rst_n = 1;
	#10000 $finish();
end

endmodule

