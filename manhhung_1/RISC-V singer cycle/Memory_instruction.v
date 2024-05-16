module Memory_instruction(
    input reset,
    input[9:0] Address,
    output [31:0] instruction
);
reg [31:0] memory_ins [61:0];
assign instruction=memory_ins[Address];
endmodule