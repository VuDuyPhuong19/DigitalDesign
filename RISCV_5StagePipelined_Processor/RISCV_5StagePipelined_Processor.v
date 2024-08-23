module RISCV_5StagePipelined_Processor #(
	parameter ADDR_WIDTH = 32
)(
	input clk,
	input rst_n,
	input irq_timer_i

	// input instr_gnt_i,
	// input instr_rvaild_i,
	// input [31:0] instr_rdata_i,
	// input [6:0] instr_rdata_intg_i,
	// input instr_err_i,

	// input data_gnt_i,
	// input data_rvaild_i,
	// input [31:0] data_rdata_i,
	// input [6:0] data_rdata_intg_i,
	// input data_err_i,

	// output instr_req_o,
	// output [ADDR_WIDTH:0] instr_addr_o,
	// output data_req_o,
	// output [31:0] data_addr_o,
	// output data_we_o,
	// output data_be_o,
	// output data_wdata_o,
	// output [6:0] data_wdata_intg_o
	
);

// Define paramaters

// IF
parameter PC_WIDTH = 32;
// parameter ADDR_WIDTH = 32;
parameter INST_WIDTH = 32;
parameter IMEM_DEPTH = 1 << 10; // 1 << 32

// ID
parameter OPCODE_R_TYPE = 7'b0110011;
parameter OPCODE_I_TYPE = 7'b0010011;
parameter OPCODE_S_TYPE = 7'b0100011;
parameter OPCODE_L_TYPE = 7'b0000011;
parameter OPCODE_B_TYPE = 7'b1100011;
parameter OPCODE_J_TYPE = 7'b1101111;
parameter OPCODE_JALR_TYPE = 7'b1100111;
parameter OPCODE_LUI_TYPE = 7'b0110111;
parameter OPCODE_AUIPC_TYPE = 7'b0010111;


parameter RESULTSRC_WIDTH = 2;
parameter ALUCONTROL_WIDTH = 4;
parameter IMMSRC_WIDTH = 2;
parameter OPCODE_WIDTH = 7;
parameter FUNCT7_WIDTH = 7;
parameter FUNCT3_WIDTH = 3;
parameter NUM_REG = 32;
parameter REG_ADDR_WIDTH = 5;
parameter REG_WIDTH = 32;
parameter IMM_WIDTH = 32;

// EX
parameter OP_WIDTH = 32;
parameter ALU_RESULT_WIDTH = 32;
parameter ADD_ALU = 4'b0000;
parameter SUB_ALU = 4'b0001;
parameter AND_ALU = 4'b0010;
parameter OR_ALU = 4'b0011;
parameter XOR_ALU = 4'b0100;
parameter SLT_ALU = 4'b0101;
parameter SLL_ALU = 4'b0110;
parameter SRA_ALU = 4'b0111;
parameter SGTe_ALU = 4'b1000;
parameter EQUAL_ALU = 4'b1001;
parameter NOT_EQUAL_ALU = 4'b1010;
parameter SRL_ALU = 4'b1011; // srl
parameter SLTU_ALU = 4'b1100; //sltu
parameter SGTeU_ALU = 4'b1101; // bgeu
parameter JALR_ALU = 4'b1110; // jalr
parameter DATA_WIDTH = 32;

// MEM 

parameter DMEM_WIDTH = 32;
parameter DMEM_DEPTH = 1 << 6; // 1 << 32

parameter PRIORITY_NMI = 5'd31;
parameter PRIORITY_FAST = 5'd30;
parameter PRIORITY_EXTERNAL = 5'd11;
parameter PRIORITY_TIMER = 5'd7;
parameter PRIORITY_SOFTWARE = 5'd3;

// WB


// Declare signals

// load and store unit

// IF

reg [PC_WIDTH-1:0] PC_F;
wire [PC_WIDTH-1:0] PCtarget_E;
wire [PC_WIDTH-1:0] pc_mux_out;
wire [PC_WIDTH-1:0] mux_pctarget_or_pc_jalr_out;
wire [PC_WIDTH-1:0] PC_jalr_E;
wire [INST_WIDTH-1:0] instruction;
wire Stall_F;
wire Stall_D;
wire [PC_WIDTH-1:0] PCplus4_F;
wire [INST_WIDTH-1:0] inst_D;
wire [PC_WIDTH-1:0] PCplus4_D;
wire [PC_WIDTH-1:0] PC_D;

// ID

wire [OPCODE_WIDTH-1:0] opcode;
reg [FUNCT7_WIDTH-1:0] funct7;
reg [FUNCT3_WIDTH-1:0] funct3;
wire RegWrite_D;
wire [RESULTSRC_WIDTH-1:0] ResultSrc_D;
wire MemWrite_D;
wire Jump_D;
wire Branch_D;
wire [ALUCONTROL_WIDTH-1:0] ALUControl_D;
wire ALUSrcB_D;
wire [1:0] ALUSrcA_D;
wire [IMMSRC_WIDTH-1:0] ImmSrc_D;

reg [REG_ADDR_WIDTH-1:0] rs1_D;
reg [REG_ADDR_WIDTH-1:0] rs2_D;
reg [REG_ADDR_WIDTH-1:0] rd_D;
wire [REG_ADDR_WIDTH-1:0] rd_W;
wire [REG_WIDTH-1:0] result_W;
wire [REG_WIDTH-1:0] rd1_D;
wire [REG_WIDTH-1:0] rd2_D;
wire [IMM_WIDTH-1:0] ImmExt_D;
wire PCJalSrc_D;
wire [1:0] write_type_D;

wire RegWrite_E;
wire [RESULTSRC_WIDTH-1:0] ResultSrc_E;
wire MemWrite_E;
wire Jump_E;
wire Branch_E;
wire [ALUCONTROL_WIDTH-1:0] ALUControl_E;
wire ALUSrcB_E;
wire [1:0] ALUSrcA_E;
wire [REG_ADDR_WIDTH-1:0] rs1_E;
wire [REG_ADDR_WIDTH-1:0] rs2_E;
wire [REG_ADDR_WIDTH-1:0] rd_E;
wire [REG_WIDTH-1:0] rd1_E;
wire [REG_WIDTH-1:0] rd2_E;
wire [IMM_WIDTH-1:0] ImmExt_E;
wire [PC_WIDTH-1:0] PCplus4_E;
wire [PC_WIDTH-1:0] PC_E;
wire PCJalSrc_E;
wire [1:0] write_type_E;

// wire [OPCODE_WIDTH-1:0] opcode_D;
// wire [FUNCT3_WIDTH-1:0] funct3_D;
// wire [FUNCT7_WIDTH-1:0] funct7_D;


// EX
wire [OP_WIDTH-1:0] SrcA_E_pre;
wire PCSrc_E;
wire zero_E;
wire [OP_WIDTH-1:0] SrcA_E;
wire [OP_WIDTH-1:0] SrcB_E;
wire signed [ALU_RESULT_WIDTH-1:0] ALU_result_E;
wire [DATA_WIDTH-1:0] WriteData_E;

wire RegWrite_M;
wire [RESULTSRC_WIDTH-1:0] ResultSrc_M;
wire MemWrite_M;
wire signed [ALU_RESULT_WIDTH-1:0] ALU_result_M;
wire [REG_ADDR_WIDTH-1:0] rd_M;
wire [PC_WIDTH-1:0] PCplus4_M;
wire [DATA_WIDTH-1:0] WriteData_M;
wire [OPCODE_WIDTH-1:0] opcode_E;
wire [FUNCT3_WIDTH-1:0] funct3_E;
wire [FUNCT7_WIDTH-1:0] funct7_E;
wire [1:0] write_type_M;

// MEM

wire [DATA_WIDTH-1:0] ReadData_M;
wire [RESULTSRC_WIDTH-1:0] ResultSrc_W;
wire [ALU_RESULT_WIDTH-1:0] ALU_result_W;
wire [DATA_WIDTH-1:0] ReadData_W;
wire [PC_WIDTH-1:0] PCplus4_W;
wire [OPCODE_WIDTH-1:0] opcode_M;
wire [FUNCT3_WIDTH-1:0] funct3_M;
wire [FUNCT7_WIDTH-1:0] funct7_M;

// WB

wire Flush_E;
wire Flush_D;
wire [1:0] ForwardA_E;
wire [1:0] ForwardB_E;
wire RegWrite_W;

//Interrupts

wire irq_nm_i;           
wire [14:0] irq_fast_i;     
wire irq_external_i;              
wire irq_software_i;         
reg irq_done;              
//wire [31:0] pc_in;          
wire [PC_WIDTH-1:0] pc_out_irq;        
wire irq_active;            
wire control_pc_irq;          
wire [PC_WIDTH-1:0] pc_mux_out2;    // for funtional interrupt


//------------------------------Instruction Fetch------------------------------//


mux_2 #(
	.MUX_DATA_WIDTH(PC_WIDTH)
) mux_pctarget_or_pc_jalr (
	.A(PCtarget_E),
	.B(PC_jalr_E),
	.control(PCJalSrc_E),
	.mux_out(mux_pctarget_or_pc_jalr_out)
);

mux_2 #(
	.MUX_DATA_WIDTH(PC_WIDTH)
) mux_pc_IF (
	.A(PCplus4_F),
	.B(mux_pctarget_or_pc_jalr_out),
	.control(PCSrc_E),
	.mux_out(pc_mux_out)
);

mux_2 #(
	.MUX_DATA_WIDTH(PC_WIDTH)
) mux_pc_interrupt (
	.A(pc_mux_out),
	.B(pc_out_irq),
	.control(control_pc_irq),
	.mux_out(pc_mux_out2)
);

// initial begin
// 	PC_F = 32'b0;
// end

// PC
always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		PC_F <= 32'h0;
	end
	else begin
		if (!Stall_F) begin
			PC_F <= pc_mux_out2;
		end
		else begin
			PC_F <= PC_F;
		end
	end
end 

// assign instruction = instr_rdata_i;
// assign instr_addr_o = PC_F;
// assign instr_req_o = 1;

IMem #(
	.ADDR_WIDTH(ADDR_WIDTH),
	.INST_WIDTH(INST_WIDTH),
	.IMEM_DEPTH(IMEM_DEPTH)
) instruction_memory (
	.Address(PC_F),
	.instruction(instruction)
);

always @ (instruction) begin
        if(instruction== 32'h0000000) begin
            irq_done = 1;
        end else begin
            irq_done = 0;
        end
end

reg_IF_ID #(
	.INST_WIDTH(INST_WIDTH),
	.PC_WIDTH(PC_WIDTH)
) reg_IF_ID (
	.clk(clk),
	.rst_n(rst_n),
	.Stall_D(Stall_D),
	.inst_F(instruction),
	.PCplus4_F(PCplus4_F),
	.PC_F(PC_F),
	.Flush_D(Flush_D),
	.inst_D(inst_D),
	.PCplus4_D(PCplus4_D),
	.PC_D(PC_D)
);

adder #(
	.ADDER_DATA_WIDTH(PC_WIDTH)
) adder (
	.opA(PC_F),
	.opB(4),
	.adder_out(PCplus4_F)
);




//------------------------------Instruction Decode-----------------------------//

assign opcode = inst_D[6:0];

always @ (*) begin
	case(opcode)
		OPCODE_R_TYPE: begin
			funct3 = inst_D[14:12];
			funct7 = inst_D[31:25];
			rs1_D = inst_D[19:15];
			rs2_D = inst_D[24:20];
			rd_D = inst_D[11:7];
		end
		OPCODE_I_TYPE: begin
			rs1_D = inst_D[19:15];
			rd_D = inst_D[11:7];
			funct3 = inst_D[14:12];
			funct7 = inst_D[31:25]; // slli, srli, srai
		end
		OPCODE_L_TYPE: begin
			rs1_D = inst_D[19:15];
			rd_D = inst_D[11:7];
			funct3 = inst_D[14:12];
		end
		OPCODE_S_TYPE: begin
			funct3 = inst_D[14:12];
			rs1_D = inst_D[19:15];
			rs2_D = inst_D[24:20];
		end
		OPCODE_B_TYPE: begin
			funct3 = inst_D[14:12];
			rs1_D = inst_D[19:15];
			rs2_D = inst_D[24:20];
		end
		OPCODE_J_TYPE: begin
			rd_D = inst_D[11:7];
		end
		OPCODE_JALR_TYPE: begin
			rs1_D = inst_D[19:15];
			rd_D = inst_D[11:7];
			funct3 = inst_D[14:12];
		end
		OPCODE_LUI_TYPE: begin
			rd_D = inst_D[11:7];
		end
		OPCODE_AUIPC_TYPE: begin
			rd_D = inst_D[11:7];
		end
		default: begin
			funct3 = 0;
			funct7 = 0;
			rs1_D = 0;
			rs2_D = 0;
			rd_D = 0;
		end
	endcase
end

control_unit #(
	.RESULTSRC_WIDTH(RESULTSRC_WIDTH),
	.ALUCONTROL_WIDTH(ALUCONTROL_WIDTH),
	.IMMSRC_WIDTH(IMMSRC_WIDTH),
	.OPCODE_WIDTH(OPCODE_WIDTH),
	.FUNCT7_WIDTH(FUNCT7_WIDTH),
	.FUNCT3_WIDTH(FUNCT3_WIDTH)
) control_unit (
	.opcode(opcode),
	.funct7(funct7),
	.funct3(funct3),
	.RegWrite_D(RegWrite_D),
	.ResultSrc_D(ResultSrc_D),
	.MemWrite_D(MemWrite_D),
	.Jump_D(Jump_D),
	.Branch_D(Branch_D),
	.ALUControl_D(ALUControl_D),
	.ALUSrcB_D(ALUSrcB_D),
	.ALUSrcA_D(ALUSrcA_D),
	.ImmSrc_D(ImmSrc_D),
	.PCJalSrc_D(PCJalSrc_D),
	.write_type_D(write_type_D)
);

reg_file #(
	.NUM_REG(NUM_REG),
	.REG_ADDR_WIDTH(REG_ADDR_WIDTH),
	.REG_WIDTH(REG_WIDTH)
) reg_file (
	.clk(clk),
	.rst_n(rst_n),
	.RegWrite(RegWrite_W),
	.addr_rs1(rs1_D),
	.addr_rs2(rs2_D),
	.addr_rd(rd_W),
	.data_rd(result_W),
	.data_rs1(rd1_D),
	.data_rs2(rd2_D)
);

imm_ext #(
	.INST_WIDTH(INST_WIDTH),
	.IMM_WIDTH(IMM_WIDTH)
) imm_ext (
	.Instruction(inst_D),
	// .funct3(funct3),
	.ImmExt_D(ImmExt_D)
);

reg_ID_EX #(
	.RESULTSRC_WIDTH(RESULTSRC_WIDTH),
	.ALUCONTROL_WIDTH(ALUCONTROL_WIDTH),
	.IMMSRC_WIDTH(IMMSRC_WIDTH),
	.REG_ADDR_WIDTH(REG_ADDR_WIDTH),
	.REG_WIDTH(REG_WIDTH),
	.IMM_WIDTH(IMM_WIDTH),
	.PC_WIDTH(PC_WIDTH),
	.OPCODE_WIDTH(OPCODE_WIDTH),
	.FUNCT7_WIDTH(FUNCT7_WIDTH),
	.FUNCT3_WIDTH(FUNCT3_WIDTH)
) reg_ID_EX (
	.clk(clk),
	.rst_n(rst_n),
	.opcode_D(opcode),
	.funct7_D(funct7),
	.funct3_D(funct3),
	.Flush_E(Flush_E),
	.RegWrite_D(RegWrite_D),
	.ResultSrc_D(ResultSrc_D),
	.MemWrite_D(MemWrite_D),
	.Jump_D(Jump_D),
	.Branch_D(Branch_D),
	.ALUControl_D(ALUControl_D),
	.ALUSrcB_D(ALUSrcB_D),
	.ALUSrcA_D(ALUSrcA_D),
	.rs1_D(rs1_D),
	.rs2_D(rs2_D),
	.rd_D(rd_D),
	.rd1_D(rd1_D),
	.rd2_D(rd2_D),
	.ImmExt_D(ImmExt_D),
	.PCplus4_D(PCplus4_D),
	.PC_D(PC_D),
	.PCJalSrc_D(PCJalSrc_D),
	.write_type_D(write_type_D),

	.opcode_E(opcode_E),
	.funct7_E(funct7_E),
	.funct3_E(funct3_E),
	.RegWrite_E(RegWrite_E),
	.ResultSrc_E(ResultSrc_E),
	.MemWrite_E(MemWrite_E),
	.Jump_E(Jump_E),
	.Branch_E(Branch_E),
	.ALUControl_E(ALUControl_E),
	.ALUSrcB_E(ALUSrcB_E),
	.ALUSrcA_E(ALUSrcA_E),
	.rs1_E(rs1_E),
	.rs2_E(rs2_E),
	.rd_E(rd_E),
	.rd1_E(rd1_E),
	.rd2_E(rd2_E),
	.ImmExt_E(ImmExt_E),
	.PCplus4_E(PCplus4_E),
	.PC_E(PC_E),
	.PCJalSrc_E(PCJalSrc_E),
	.write_type_E(write_type_E)
);


//------------------------------------Execute----------------------------------// 


assign PCSrc_E = Jump_E | (Branch_E & (zero_E | ALU_result_E));
assign PCtarget_E = ImmExt_E + PC_E;

assign PC_jalr_E = ALU_result_E;

assign SrcA_E_pre = (ForwardA_E == 2'b00) ? rd1_E : ((ForwardA_E == 2'b01) ? result_W : ((ForwardA_E == 2'b10) ? ALU_result_M : 0));
assign WriteData_E = (ForwardB_E == 2'b00) ? rd2_E : ((ForwardB_E == 2'b01) ? result_W : ((ForwardB_E == 2'b10) ? ALU_result_M : 0));
assign SrcB_E = ALUSrcB_E ? ImmExt_E : WriteData_E;
assign SrcA_E = (ALUSrcA_E == 2'b00) ? 0 : ((ALUSrcA_E == 2'b01) ? SrcA_E_pre : ((ALUSrcA_E == 2'b10) ? PC_E : 0));

alu #(
	.OP_WIDTH(OP_WIDTH),
	.OPCODE_WIDTH(OPCODE_WIDTH),
	.FUNCT3_WIDTH(FUNCT3_WIDTH),
	.ALUCONTROL_WIDTH(ALUCONTROL_WIDTH),
	.ALU_RESULT_WIDTH(ALU_RESULT_WIDTH),
	.ADD_ALU(ADD_ALU),
	.SUB_ALU(SUB_ALU),
	.AND_ALU(AND_ALU),
	.OR_ALU(OR_ALU),
	.XOR_ALU(XOR_ALU),
	.SLT_ALU(SLT_ALU),
	.SLL_ALU(SLL_ALU),
	.SRA_ALU(SRA_ALU),
	.SGTe_ALU(SGTe_ALU),
	.EQUAL_ALU(EQUAL_ALU),
	.NOT_EQUAL_ALU(NOT_EQUAL_ALU),
	.SRL_ALU(SRL_ALU),
	.SLTU_ALU(SLTU_ALU),
	.SGTeU_ALU(SGTeU_ALU),
	.JALR_ALU(JALR_ALU)
) alu (
	.opA(SrcA_E),
	.opB(SrcB_E),
	.ALUControl_E(ALUControl_E),
	.opcode_E(opcode_E),
	.funct3_E(funct3_E),
	.zero_E(zero_E),
	.ALU_result_E(ALU_result_E)
);

multiplier #(
	.OP_WIDTH(OP_WIDTH),
	.RESULT_WIDTH(RESULT_WIDTH)
) multiplier_uut (
	.clk_i(clk),
	.rst_ni(rst_n),
	.start_i(),
	.operand_a_i(),
	.operand_b_i(),
	.func_i(),
	.result_o().
	.mult_done_o()
);

divider #(
	.OP_WIDTH(OP_WIDTH),
	.RESULT_WIDTH(RESULT_WIDTH)
) divider_uut (
	.clk_i(clk),
	.rst_ni(rst_n),
	.start_i(),
	.operand_a_i(),
	.operand_b_i(),
	.func_i(),
	.result_o().
	.div_done_o()	
);

reg_EX_MEM #(
	.RESULTSRC_WIDTH(RESULTSRC_WIDTH),
	.ALU_RESULT_WIDTH(ALU_RESULT_WIDTH),
	.REG_ADDR_WIDTH(REG_ADDR_WIDTH),
	.PC_WIDTH(PC_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.OPCODE_WIDTH(OPCODE_WIDTH),
	.FUNCT7_WIDTH(FUNCT7_WIDTH),
	.FUNCT3_WIDTH(FUNCT3_WIDTH)
) reg_EX_MEM (
	.clk(clk),
	.rst_n(rst_n),
	.opcode_E(opcode_E),
	.funct7_E(funct7_E),
	.funct3_E(funct3_E),
	.RegWrite_E(RegWrite_E),
	.ResultSrc_E(ResultSrc_E),
	.MemWrite_E(MemWrite_E),
	.ALU_result_E(ALU_result_E),
	.rd_E(rd_E),
	.PCplus4_E(PCplus4_E),
	.WriteData_E(WriteData_E),
	.write_type_E(write_type_E),

	.opcode_M(opcode_M),
	.funct7_M(funct7_M),
	.funct3_M(funct3_M),
	.RegWrite_M(RegWrite_M),
	.ResultSrc_M(ResultSrc_M),
	.MemWrite_M(MemWrite_M),
	.ALU_result_M(ALU_result_M),
	.rd_M(rd_M),
	.PCplus4_M(PCplus4_M),
	.WriteData_M(WriteData_M),
	.write_type_M(write_type_M)
);


//---------------------------------Memory Access-------------------------------// 

DMem #(
	.ADDR_WIDTH(ADDR_WIDTH),
	.DMEM_WIDTH(DMEM_WIDTH),
	.DMEM_DEPTH(DMEM_DEPTH)
) dmem (
	.clk(clk),
	.rst_n(rst_n),
	.MemWrite(MemWrite_M),
	.addr(ALU_result_M),
	.write_data(WriteData_M),
	.write_type_M(write_type_M),
	.read_data(ReadData_M)
);

// assign data_req_o = 1;
// assign data_addr_o = ALU_result_M;
// assign data_we_o = MemWrite_M;
// assign data_be_o = write_type_M;
// assign data_wdata_o = WriteData_M;
// assign data_rdata_i = ReadData_M;

reg_MEM_WB #(
	.RESULTSRC_WIDTH(RESULTSRC_WIDTH),
	.REG_ADDR_WIDTH(REG_ADDR_WIDTH),
	.ALU_RESULT_WIDTH(ALU_RESULT_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.PC_WIDTH(PC_WIDTH)
) reg_MEM_WB (
	.clk(clk),
	.rst_n(rst_n),
	.opcode_M(opcode_M),
	.funct3_M(funct3_M),
	.RegWrite_M(RegWrite_M),
	.ResultSrc_M(ResultSrc_M),
	.rd_M(rd_M),
	.ALU_result_M(ALU_result_M),
	.ReadData_M(ReadData_M),
	.PCplus4_M(PCplus4_M),
	.RegWrite_W(RegWrite_W),
	.ResultSrc_W(ResultSrc_W),
	.rd_W(rd_W),
	.ALU_result_W(ALU_result_W),
	.ReadData_W(ReadData_W),
	.PCplus4_W(PCplus4_W)
);

//-----------------------------------Write back--------------------------------//

assign result_W = (ResultSrc_W == 2'b00) ? ALU_result_W : ((ResultSrc_W == 2'b01) ? ReadData_W : ((ResultSrc_W == 2'b10) ? PCplus4_W : 0));


// Hazard Unit

hazard_unit #(
	.REG_ADDR_WIDTH(REG_ADDR_WIDTH),
	.RESULTSRC_WIDTH(RESULTSRC_WIDTH)
) hazard_unit (
	.rd_W(rd_W),
	.rd_M(rd_M),
	.rd_E(rd_E),
	.rs1_E(rs1_E),
	.rs2_E(rs2_E),
	.rs1_D(rs1_D),
	.rs2_D(rs2_D),
	.RegWrite_M(RegWrite_M),
	.RegWrite_W(RegWrite_W),
	.ResultSrc_E(ResultSrc_E),
	.PCSrc_E(PCSrc_E),
	.ForwardA_E(ForwardA_E),
	.ForwardB_E(ForwardB_E),
	.Stall_F(Stall_F),
	.Stall_D(Stall_D),
	.Flush_D(Flush_D),
	.Flush_E(Flush_E)
);

//---------------------------------Interrupt--------------------------------------//

Interrupt #(
	.PRIORITY_NMI(PRIORITY_NMI),
    .PRIORITY_FAST(PRIORITY_FAST),
    .PRIORITY_EXTERNAL(PRIORITY_EXTERNAL),
    .PRIORITY_TIMER(PRIORITY_TIMER),
    .PRIORITY_SOFTWARE(PRIORITY_SOFTWARE)
) irq_uut (
	.clk(clk),
	.rst_n(rst_n),
	.irq_nm_i(1'b0),           
	.irq_fast_i(irq_fast_i),    
	.irq_external_i(1'b0),       
	.irq_timer_i(irq_timer_i),         
	.irq_software_i(1'b0),         
	.irq_done(irq_done),            
	.pc_in_irq(PCplus4_F),       
	.pc_out_irq(pc_out_irq),   
	.irq_active(irq_active),            
	.control_pc_irq(control_pc_irq)  
);

endmodule