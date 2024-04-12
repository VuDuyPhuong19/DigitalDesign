`timescale 1ns / 1ps

module iir_filter_tb;

parameter DATA_BIT_NUM = 16;
parameter SAMPLES = 1024;
reg clk, rst;
reg signed [DATA_BIT_NUM-1:0] data_in;
wire signed [DATA_BIT_NUM-1:0] data_out;
reg [DATA_BIT_NUM-1:0] data_array [0:SAMPLES-1];
integer i;
reg signed [DATA_BIT_NUM-1:0] gain = 1;

// Clock generation
always begin
    forever #10 clk = ~clk;
end

// Module instantiation
iir_stage irr_filter_1 (
    .clk(clk),
    .rst(rst),
    .gain(gain),
    .data_in(data_in),
    .data_out(data_out)
);

// Test procedure
initial begin
    clk = 0;
    rst = 1;
    data_in = 0;
    i = 0;

    $readmemb("sin_noise.txt", data_array);
    #20 rst = 0;  // Reset deactivation aligned with the clock edge

    for (i = 0; i < SAMPLES; i = i + 1) begin
        @ (posedge clk);
        data_in = data_array[i];
    end
    #1000; // Time to observe after last input
end

endmodule