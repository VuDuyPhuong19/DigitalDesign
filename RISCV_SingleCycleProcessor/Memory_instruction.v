module Memory_instruction #(
    parameter ADDR_WIDTH = 32,
    parameter INST_WIDTH = 32,
    parameter IMEM_DEPTH = 1 << 10 // 1 << 32
)(
    input [ADDR_WIDTH-1:0] Address,
    output [INST_WIDTH-1:0] instruction
);
reg [31:0] memory_ins [IMEM_DEPTH-1:0];

integer i;
initial begin
    memory_ins[0] = 32'b00000000001100010000000010110011;
    memory_ins[1] = 32'b01000000001100010000000010110011;
    memory_ins[2] = 32'b00000000001100010000000010110011;
end

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
