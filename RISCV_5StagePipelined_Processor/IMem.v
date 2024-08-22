// module IMem #(
//     parameter ADDR_WIDTH = 32,
//     parameter INST_WIDTH = 32,
//     parameter IMEM_DEPTH = 1 << 10 // 1 << 32
// )(
//     input [ADDR_WIDTH-1:0] Address,
//     output [INST_WIDTH-1:0] instruction
// );
// reg [31:0] memory_ins [IMEM_DEPTH-1:0];

// initial begin
//     // memory_ins[0] = 32'b00000000000100000000000010010011; // add x1, x2, x3 
//     // memory_ins[1] = 32'b00000001111100001001000100010011; // addi x2, x0, 2
//     // memory_ins[2] = 32'b00001111111100000000000110010011; // addi x3, x0, 7
//     // memory_ins[3] = 32'b00000000001100010010000000100011; // sub x1, x2, x3
//     // memory_ins[4] = 32'b00000000000000010000001000110011; // add x4, x2, x3
//     // memory_ins[5] = 32'b11111111111100100000001000010011; // sll x5, x4, x2                        
//     // memory_ins[6] = 32'b11111110000000100001111011100011; // addi x2, x1, 2
//     // memory_ins[7] = 32'b00000000000000000000000110010011; // addi x2, x0, 8
//     // memory_ins[8] = 32'b00000000001100010010000000100011; // sb x1, 1(x2) (store x1 = -10)
//     // memory_ins[9] = 32'b00000000000000010000001000110011; // lb x4, 1(x2) (x4 = -10)
//     // memory_ins[10] = 32'b11111111111100100000001000010011; // addi x5, x4, 3 (x5 = -7)
//     // memory_ins[11] = 32'b11111110000000100001111011100011; // addi x5, x0, 10
//     // memory_ins[12] = 32'b11111101100111111111001011101111; // addi x6, x0, 9

//     memory_ins[0] = 32'b00000000000100000000000010010011; // add x1, x2, x3 
//     memory_ins[4] = 32'b00000001111100001001000100010011; // addi x2, x0, 2
//     memory_ins[8] = 32'b00001111111100000000000110010011; // addi x3, x0, 7
//     memory_ins[12] = 32'b00000000001100010010000000100011; // sub x1, x2, x3
//     memory_ins[16] = 32'b00000000101000000000001000010011; // add x4, x2, x3
//     memory_ins[20] = 32'b11111111111100100000001000010011; // sll x5, x4, x2                        
//     memory_ins[24] = 32'b11111110000000100001111011100011; // addi x2, x1, 2
//     memory_ins[28] = 32'b00000000000000000000000110010011; // addi x2, x0, 8
//     memory_ins[32] = 32'b00000000001100010010000000100011; // sb x1, 1(x2) (store x1 = -10)
//     memory_ins[36] = 32'b00000000101000000000001000010011; // lb x4, 1(x2) (x4 = -10)
//     memory_ins[40] = 32'b11111111111100100000001000010011; // addi x5, x4, 3 (x5 = -7)
//     memory_ins[44] = 32'b11111110000000100001111011100011; // addi x5, x0, 10
//     memory_ins[48] = 32'b11111101100111111111001011101111; // addi x6, x0, 9


//     // memory_ins[13] = 32'b11111101100111111111001011101111; // bge x5, x6, 8 (pc_next = 13 + 8 = 21)

//     // memory_ins[14] = 32'b111111110110_00001_000_00100_0010011; // addi x4, x1, -10
//     // memory_ins[15] = 32'b000000001100_00000_000_00011_0010011; // addi x3, x0, 12
//     // memory_ins[16] = 32'b0000000_00011_00010_000_00100_0110011; // add x4, x2, x3
//     // memory_ins[17] = 32'b111111111011_00100_000_00101_0010011; // addi x5, x4, -5 (x5 = -15)

//     // memory_ins[21] = 32'b111111111011_00100_000_00101_0010011; // addi x5, x4, -5 (x5 = -15)
//     // memory_ins[22] = 32'b00000000100000000000000011101111; // jal x1, 8 (pc_next = 22 + 8 = 30)

//     // memory_ins[23] = 32'b111111111011_00001_000_00001_0010011; // addi x1, x1, -5
//     // memory_ins[24] = 32'b000000000010_00000_000_00010_0010011; // addi x2, x0, 2
//     // memory_ins[25] = 32'b111111110110_00001_000_00100_0010011; // addi x4, x1, -10

//     // memory_ins[30] = 32'b111111111011_00001_000_00001_0010011; // addi x1, x1, -5
//     // memory_ins[31] = 32'b000000000010_00000_000_00010_0010011; // addi x2, x0, 2
//     // memory_ins[32] = 32'b111111110110_00001_000_00011_0010011; // addi x3, x1, -10
//     // memory_ins[33] = 32'b00000000000000000100001010110111; // lui x5, 4 (x5 = 0x4000)
//     // memory_ins[34] = 32'b00000000001100101000000010010011; // addi x1, x5, 3 (x1 = 0x4000)
//     // memory_ins[35] = 32'b00000000000000000011000110010111; // auipc x3, 3 (x3 = 0x3000 + 35)
//     // memory_ins[36] = 32'b00000000001100001100010100110011; // xor x10, x1, x3 
//     // memory_ins[37] = 32'b00000000010100010010001110010011; // slti x7, x2, 5 
//     // memory_ins[38] = 32'b00000000101000110011010000010011; // sltiu x8, x6, 10 
//     // memory_ins[39] = 32'b00000010101000110000000011100111; // jalr x1, 42(x6)  (x6 = 9) (pc_next = 50)

//     // memory_ins[40] = 32'b00000001010000000000_00001_1101111; // bne 
//     // memory_ins[41] = 32'b00000001010000000000_00001_1101111; // 
//     // memory_ins[42] = 32'b00000001010000000000_00001_1101111; // jalr x1, 49(x6)

//     // memory_ins[49] = 32'b00000001010000000000_00001_1101111; // bne 
//     // memory_ins[50] = 32'b00000000001100001000001010010011; // addi x5, x1, 3
//     // memory_ins[51] = 32'b00000001010000000000_00001_1101111; // jalr x1, 49(x6)

// end

// // initial begin
// //     $readmemb("D:/Verilog project/DigitalDesign/DigitalDesign/RISCV_5StagePipelined_Processor/Data_Instruction/simple.bin", memory_ins);
// // end

// assign instruction = memory_ins[Address];

// endmodule

// module Memory_instruction_tb();
// parameter ADDR_WIDTH = 32;
// parameter INST_WIDTH = 32;

// reg [ADDR_WIDTH-1:0] Address;
// wire [INST_WIDTH-1:0] instruction;

// Memory_instruction uut(.Address(Address),
//                        .instruction(instruction));

// initial begin
//     Address = 8'h00000000;
//     #10 Address = 8'h00000001;
//     #10 Address = 8'h00000002;
//     #100 $finish();
// end

// endmodule

module IMem #(
    parameter ADDR_WIDTH = 32,
    parameter INST_WIDTH = 32,
    parameter IMEM_DEPTH = 1 << 10 // 1 << 32
)(
    input [ADDR_WIDTH-1:0] Address,
    output [INST_WIDTH-1:0] instruction
);
reg [31:0] memory_ins [IMEM_DEPTH-1:0];

initial begin
    // memory_ins[0] = 32'b00000000000100000000000010010011; // add x1, x2, x3 
    // memory_ins[1] = 32'b00000001111100001001000100010011; // addi x2, x0, 2
    // memory_ins[2] = 32'b00001111111100000000000110010011; // addi x3, x0, 7
    // memory_ins[3] = 32'b00000000001100010010000000100011; // sub x1, x2, x3
    // memory_ins[4] = 32'b00000000000000010000001000110011; // add x4, x2, x3
    // memory_ins[5] = 32'b11111111111100100000001000010011; // sll x5, x4, x2                        
    // memory_ins[6] = 32'b11111110000000100001111011100011; // addi x2, x1, 2
    // memory_ins[7] = 32'b00000000000000000000000110010011; // addi x2, x0, 8
    // memory_ins[8] = 32'b00000000001100010010000000100011; // sb x1, 1(x2) (store x1 = -10)
    // memory_ins[9] = 32'b00000000000000010000001000110011; // lb x4, 1(x2) (x4 = -10)
    // memory_ins[10] = 32'b11111111111100100000001000010011; // addi x5, x4, 3 (x5 = -7)
    // memory_ins[11] = 32'b11111110000000100001111011100011; // addi x5, x0, 10
    // memory_ins[12] = 32'b11111101100111111111001011101111; // addi x6, x0, 9

     // Nạp các lệnh vào memory_ins bằng định dạng hex
    memory_ins[0]  = 32'h00100093; // addi x1, x0, 1
    memory_ins[4]  = 32'h01f09113; // addi x4, x0, 2000
    memory_ins[8]  = 32'h0ff00193; // addi x3, x0, 0x00FFs
    memory_ins[12] = 32'h00312023; // sw x3, 0(x2)

    memory_ins[16] = 32'h00100093; // addi x1, x0, 1
    memory_ins[20] = 32'h00100094; // addi x1, x0, 1                    
    memory_ins[24] = 32'h00100095; // addi x1, x0, 1
    memory_ins[28] = 32'h00100096; // addi x1, x0, 1
    memory_ins[32] = 32'h00100097; // addi x1, x0, 1

    // Lệnh ngắt
    memory_ins[36] = 32'h00a00513; // addi x10, x0, 10
    memory_ins[40] = 32'h00a00613; // addi x12, x0, 10
    memory_ins[44] = 32'h00d06513; // addi x13, x10, 13
    memory_ins[48] = 32'h30200073; // mret
    // interrupt
    memory_ins[300] = 32'h00a00514; // addi x10, x0, 10
    memory_ins[304] = 32'h00a00624; // addi x12, x0, 10
    memory_ins[308] = 32'h00d06534; // addi x13, x10, 13
    memory_ins[312] = 32'h00e06713; // addi x14, x12, 14
    memory_ins[316] = 32'h30200073; // mret
    memory_ins[320] = 32'h00000000; // mret
    
    // mret


    // memory_ins[13] = 32'b11111101100111111111001011101111; // bge x5, x6, 8 (pc_next = 13 + 8 = 21)

    // memory_ins[14] = 32'b111111110110_00001_000_00100_0010011; // addi x4, x1, -10
    // memory_ins[15] = 32'b000000001100_00000_000_00011_0010011; // addi x3, x0, 12
    // memory_ins[16] = 32'b0000000_00011_00010_000_00100_0110011; // add x4, x2, x3
    // memory_ins[17] = 32'b111111111011_00100_000_00101_0010011; // addi x5, x4, -5 (x5 = -15)

    // memory_ins[21] = 32'b111111111011_00100_000_00101_0010011; // addi x5, x4, -5 (x5 = -15)
    // memory_ins[22] = 32'b00000000100000000000000011101111; // jal x1, 8 (pc_next = 22 + 8 = 30)

    // memory_ins[23] = 32'b111111111011_00001_000_00001_0010011; // addi x1, x1, -5
    // memory_ins[24] = 32'b000000000010_00000_000_00010_0010011; // addi x2, x0, 2
    // memory_ins[25] = 32'b111111110110_00001_000_00100_0010011; // addi x4, x1, -10

    // memory_ins[30] = 32'b111111111011_00001_000_00001_0010011; // addi x1, x1, -5
    // memory_ins[31] = 32'b000000000010_00000_000_00010_0010011; // addi x2, x0, 2
    // memory_ins[32] = 32'b111111110110_00001_000_00011_0010011; // addi x3, x1, -10
    // memory_ins[33] = 32'b00000000000000000100001010110111; // lui x5, 4 (x5 = 0x4000)
    // memory_ins[34] = 32'b00000000001100101000000010010011; // addi x1, x5, 3 (x1 = 0x4000)
    // memory_ins[35] = 32'b00000000000000000011000110010111; // auipc x3, 3 (x3 = 0x3000 + 35)
    // memory_ins[36] = 32'b00000000001100001100010100110011; // xor x10, x1, x3 
    // memory_ins[37] = 32'b00000000010100010010001110010011; // slti x7, x2, 5 
    // memory_ins[38] = 32'b00000000101000110011010000010011; // sltiu x8, x6, 10 
    // memory_ins[39] = 32'b00000010101000110000000011100111; // jalr x1, 42(x6)  (x6 = 9) (pc_next = 50)

    // memory_ins[40] = 32'b00000001010000000000_00001_1101111; // bne 
    // memory_ins[41] = 32'b00000001010000000000_00001_1101111; // 
    // memory_ins[42] = 32'b00000001010000000000_00001_1101111; // jalr x1, 49(x6)

    // memory_ins[49] = 32'b00000001010000000000_00001_1101111; // bne 
    // memory_ins[50] = 32'b00000000001100001000001010010011; // addi x5, x1, 3
    // memory_ins[51] = 32'b00000001010000000000_00001_1101111; // jalr x1, 49(x6)

end

// initial begin
//     $readmemb("D:/Verilog project/DigitalDesign/DigitalDesign/RISCV_5StagePipelined_Processor/Data_Instruction/simple.bin", memory_ins);
// end

assign instruction = memory_ins[Address];

endmodule

module Memory_instruction_tb();
parameter ADDR_WIDTH = 32;
parameter INST_WIDTH = 32;

reg [ADDR_WIDTH-1:0] Address;
wire [INST_WIDTH-1:0] instruction;

Memory_instruction uut(.Address(Address),
                       .instruction(instruction));

initial begin
    Address = 8'h00000000;
    #10 Address = 8'h00000001;
    #10 Address = 8'h00000002;
    #100 $finish();
end

endmodule