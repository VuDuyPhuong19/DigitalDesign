`timescale 1ns/1ns
module RISCV_5StagePipelined_Processor_tb();

  // Testbench signals
  reg clk;
  reg rst_n;

  // Instantiate the DUT (Device Under Test)
  RISCV_5StagePipelined_Processor dut (
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk; // 20ns period, 50MHz clock
  end

  // Test procedure
  initial begin
    // Initialize the reset signal
    rst_n = 0;

    // Wait for a few clock cycles
    #10;

    // De-assert reset
    rst_n = 1;

    // Run the processor for a few cycles
    #500000;


    // Stop the simulation
    $finish();
  end

  integer i;
  initial begin
    i = 0;
  end

      // Giám sát đầu ra
    always @(posedge clk) begin

        $display("i = %d, %0t: PC_F = %d, PC_E = %d, PCtarget_E = %d, mux_pctarget_or_pc_jalr_out = %d, ALUControl_E = %b, PCplus4_W = %d, instruction: %h, ImmExt_D = %d, ImmExt_E = %d,rd_D = %h, rd_E = %h, rs1_D = %h, rs2_D = %h, rd1_D = %h, rd1_E = %h, rd2_D = %h, rd2_E = %h, ALUSrcA_D = %h, ALUSrcB_D = %h, ALUSrcA_E = %h, ALUSrcB_E = %h, WriteData_E = %h, WriteData_M = %h, write_type_M = %h, MemWrite_M = %h, Stall_D = %h, Stall_F = %h, zero_E = %h, Flush_D = %h, Flush_E = %h, ResultSrc_E = %h, PCSrc_E = %h, PCJalSrc_E = %h, rs1_E = %h, rs2_E = %h, rd_M = %h, rd_W = %h, RegWrite_D = %h, RegWrite_E = %h, RegWrite_M = %h, RegWrite_W = %h, reg_file_RegWrite = %h, ALU_result_M = %h, opcode_E = %h, funct7_E = %h, funct3_E = %h, rd_E_1 = %h, rd_E_2 = %h, reg_EX_MEM_rd_E = %h, is_mult_div = %h, start_mult_E = %h, start_mult_E_1 = %h, start_mult_E_2 = %h, start_mult_E_3 = %h, start_div_E = %h, start_div_E_1 = %h, start_div_E_2 = %h, start_div_E_3 = %h, div_func_E = %h, mult_done_o_E = %h, div_done_o_E = %h, mult_or_div_done_E = %h, mult_result_E = %h, div_result_E = %h, calc_result_src_E = %h, calc_result_E = %h, calc_result_M = %h, ALUControl_E = %b, ReadData_M = %h, ReadData_W = %h, result_W = %h, ResultSrc_W = %h, ForwardA_E = %h, ForwardB_E = %h, SrcA_E_pre = %h, SrcA_E= %d, SrcB_E = %d, ALU_result_E: %d \n", 
             i,
             $time,
             dut.PC_F, 
             dut.PC_E,
             dut.PCtarget_E,
             dut.mux_pctarget_or_pc_jalr_out,
             dut.ALUControl_E,
             dut.PCplus4_W,
             dut.instruction_memory.instruction, 
             dut.ImmExt_D,
             dut.ImmExt_E,
             dut.rd_D, 
             dut.rd_E, 
             dut.rs1_D, 
             dut.rs2_D, 
             dut.rd1_D, 
             dut.reg_ID_EX.rd1_E, 
             dut.rd2_D, 
             dut.reg_ID_EX.rd2_E, 
             dut.ALUSrcA_D,
             dut.ALUSrcB_D,
             dut.ALUSrcA_E,
             dut.ALUSrcB_E,
             dut.WriteData_E,
             dut.WriteData_M,
             dut.write_type_M,
             dut.MemWrite_M,
             dut.Stall_D,
             dut.Stall_F,
             dut.zero_E,
             dut.Flush_D,
             dut.Flush_E,
             dut.ResultSrc_E,
             dut.PCSrc_E,
             dut.PCJalSrc_E,
             dut.rs1_E,
             dut.rs2_E,
             dut.rd_M,
             dut.rd_W,
             dut.RegWrite_D,
             dut.RegWrite_E,
             dut.RegWrite_M,
             dut.RegWrite_W,
             dut.reg_file_RegWrite,
             dut.ALU_result_M,
             dut.opcode_E,
             dut.funct7_E,
             dut.funct3_E,
             dut.rd_E_1,
             dut.rd_E_2,
             dut.reg_EX_MEM_rd_E,
             dut.is_mult_div,
             dut.start_mult_E,
             dut.start_mult_E_1,
             dut.start_mult_E_2,
             dut.start_mult_E_3,
             dut.start_div_E,
             dut.start_div_E_1,
             dut.start_div_E_2,
             dut.start_div_E_3,
             dut.div_func_E,
             dut.mult_done_o_E,
             dut.div_done_o_E,
             dut.mult_or_div_done_E,
             dut.mult_result_E,
             dut.div_result_E,
             dut.calc_result_src_E,
             dut.calc_result_E,
             dut.calc_result_M,
             dut.ALUControl_E,
             dut.ReadData_M,
             dut.ReadData_W,
             dut.result_W,
             dut.ResultSrc_W,
             dut.ForwardA_E,
             dut.ForwardB_E,
             dut.SrcA_E_pre,
             dut.SrcA_E,
             dut.SrcB_E,
             dut.alu.ALU_result_E);
        i = i + 1;
      if (i > 1000) begin
        $finish();
      end
    end

endmodule



// Interrupt 

// `timescale 1ns/1ns
// module RISCV_5StagePipelined_Processor_tb();

//   // Testbench signals
//   reg clk;
//   reg rst_n;
//   reg irq_timer_i;

//   // Instantiate the DUT (Device Under Test)
//   RISCV_5StagePipelined_Processor dut (
//     .irq_timer_i(irq_timer_i),
//     .clk(clk),
//     .rst_n(rst_n)
//   );

//   // Clock generation
//   initial begin
//     clk = 0;
//     forever #10 clk = ~clk; // 20ns period, 50MHz clock
//   end

//   // Test procedure
//   initial begin
//     // Initialize the reset signal
//     rst_n = 0;
//     irq_timer_i=0;

//     // Wait for a few clock cycles
//     #10;
//     rst_n = 1;
    
//     #162;
//     irq_timer_i=1;
//     #20;
//     irq_timer_i=0;

//     // Run the processor for a few cycles
//     #500000;


//     // Stop the simulation
//     $finish();
//   end

//   integer i;
//   initial begin
//     i = 0;
//   end

//       // Giám sát đầu ra
// always @(posedge clk) begin
//     $display("i = %d, %0t: PC_F = %d, PC_E = %d, PCtarget_E = %d, mux_pctarget_or_pc_jalr_out = %d, \
//     ALUControl_E = %b, PCplus4_W = %d, instruction: %h, ImmExt_D = %d, ImmExt_E = %d, rd_D = %h, rd_E = %h, \
//     rs1_D = %h, rs2_D = %h, rd1_D = %h, rd1_E = %h, rd2_D = %h, rd2_E = %h, ALUSrcA_D = %h, ALUSrcB_D = %h, \
//     ALUSrcA_E = %h, ALUSrcB_E = %h, WriteData_E = %h, WriteData_M = %h, write_type_M = %h, MemWrite_M = %h, \
//     Stall_D = %h, Stall_F = %h, zero_E = %h, Flush_D = %h, Flush_E = %h, ResultSrc_E = %h, PCSrc_E = %h, \
//     PCJalSrc_E = %h, rs1_E = %h, rs2_E = %h, rd_M = %h, rd_W = %h, RegWrite_D = %h, RegWrite_M = %h, \
//     RegWrite_W = %h, ALU_result_M = %h, ALU_result_W = %h, ALUControl_E = %b, ReadData_M = %h, ReadData_W = %h, \
//     result_W = %h, ResultSrc_W = %h, ForwardA_E = %h, ForwardB_E = %h, SrcA_E_pre = %h, SrcA_E = %d, \
//     SrcB_E = %d, ALU_result_E: %d, pc_mux_out: %d, control_pc_irq: %d, pc_mux_out2: %d, pc_out_irq: %d, \
//     irq_uut.pc_in_irq: %d  \n\n", 
//     i,
//     $time,
//     dut.PC_F, 
//     dut.PC_E,
//     dut.PCtarget_E,
//     dut.mux_pctarget_or_pc_jalr_out,
//     dut.ALUControl_E,
//     dut.PCplus4_W,
//     dut.instruction_memory.instruction, 
//     dut.ImmExt_D,
//     dut.ImmExt_E,
//     dut.rd_D, 
//     dut.rd_E, 
//     dut.rs1_D, 
//     dut.rs2_D, 
//     dut.rd1_D, 
//     dut.reg_ID_EX.rd1_E, 
//     dut.rd2_D, 
//     dut.reg_ID_EX.rd2_E, 
//     dut.ALUSrcA_D,
//     dut.ALUSrcB_D,
//     dut.ALUSrcA_E,
//     dut.ALUSrcB_E,
//     dut.WriteData_E,
//     dut.WriteData_M,
//     dut.write_type_M,
//     dut.MemWrite_M,
//     dut.Stall_D,
//     dut.Stall_F,
//     dut.zero_E,
//     dut.Flush_D,
//     dut.Flush_E,
//     dut.ResultSrc_E,
//     dut.PCSrc_E,
//     dut.PCJalSrc_E,
//     dut.rs1_E,
//     dut.rs2_E,
//     dut.rd_M,
//     dut.rd_W,
//     dut.RegWrite_D,
//     dut.RegWrite_M,
//     dut.RegWrite_W,
//     dut.ALU_result_M,
//     dut.ALU_result_W,
//     dut.ALUControl_E,
//     dut.ReadData_M,
//     dut.ReadData_W,
//     dut.result_W,
//     dut.ResultSrc_W,
//     dut.ForwardA_E,
//     dut.ForwardB_E,
//     dut.SrcA_E_pre,
//     dut.SrcA_E,
//     dut.SrcB_E,
//     dut.alu.ALU_result_E,
//     dut.pc_mux_out,
//     dut.control_pc_irq,
//     dut.pc_mux_out2,
//     dut.pc_out_irq,
//     dut.irq_uut.pc_in_irq
//     );
    
//     i = i + 1;
    
//     if (i > 50) begin
//         $finish();
//     end
// end


// endmodule
