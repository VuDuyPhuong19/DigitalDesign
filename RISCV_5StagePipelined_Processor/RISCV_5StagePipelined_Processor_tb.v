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

        $display("i = %d, %0t: PC_F = %d, PCtarget_E = %d, PCplus4_W = %d, instruction: %h, ImmExt_D = %h, rd_D = %h, rd_E = %h, rs1_D = %h, rs2_D = %h, rd1_D = %h, rd1_E = %h, rd2_D = %h, rd2_E = %h, ALUSrc_E = %h, WriteData_E = %h, WriteData_M = %h, MemWrite_M = %h, Stall_D = %h, Stall_F = %h, zero_E = %h, Flush_D = %h, Flush_E = %h, ResultSrc_E = %h, PCSrc_E = %h, rs1_E = %h, rs2_E = %h, rd_M = %h, rd_W = %h, RegWrite_M = %h, RegWrite_W = %h, ALU_result_M = %h, ALU_result_W = %h, ReadData_M = %h, ReadData_W = %h, result_W = %h, ResultSrc_W = %h, ForwardA_E = %h, ForwardB_E = %h, SrcA_E= %h, SrcB_E = %h, ALU_result_E: %d \n", 
             i,
             $time,
             dut.PC_F, 
             dut.PCtarget_E,
             dut.PCplus4_W,
             dut.instruction_memory.instruction, 
             dut.ImmExt_D,
             dut.rd_D, 
             dut.rd_E, 
             dut.rs1_D, 
             dut.rs2_D, 
             dut.rd1_D, 
             dut.reg_ID_EX.rd1_E, 
             dut.rd2_D, 
             dut.reg_ID_EX.rd2_E, 
             dut.ALUSrc_E,
             dut.WriteData_E,
             dut.WriteData_M,
             dut.MemWrite_M,
             dut.Stall_D,
             dut.Stall_F,
             dut.zero_E,
             dut.Flush_D,
             dut.Flush_E,
             dut.ResultSrc_E,
             dut.PCSrc_E,
             dut.rs1_E,
             dut.rs2_E,
             dut.rd_M,
             dut.rd_W,
             dut.RegWrite_M,
             dut.RegWrite_W,
             dut.ALU_result_M,
             dut.ALU_result_W,
             dut.ReadData_M,
             dut.ReadData_W,
             dut.result_W,
             dut.ResultSrc_W,
             dut.ForwardA_E,
             dut.ForwardB_E,
             dut.SrcA_E,
             dut.SrcB_E,
             dut.alu.ALU_result_E);
        i = i + 1;
      if (i > 1000) begin
        $finish();
      end
    end

endmodule
