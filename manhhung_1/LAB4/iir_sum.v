module iir_sum(
    input wire clk,
    input wire rst,
    input wire signed [15:0] data_in,    // Äáº§u vÃ o cá»§a bá» lá»c
    output wire signed [15:0] data_out   // Äáº§u ra cá»§a bá» lá»c
);
parameter DATA_BIT_NUM = 16;
// CÃ¡c há» sá» bá» lá»c cho tá»«ng stage
wire signed [31:0] coeff_in_1=32'h000368fb, coeff_in_2=32'h0006d1f5, coeff_in_3=32'h000368fb, coeff_out_1=32'he12eabf5, coeff_out_2=32'h0edfe638;
wire signed [31:0] coeff_in_1_1=32'h10000000 , coeff_in_2_1=32'he0000000, coeff_in_3_1=32'h10000000, coeff_out_1_1=32'he02a9027, coeff_out_2_1=32'h0fd5bd9d;
//wire signed [31:0] coeff_in_1_2=32'h10000000, coeff_in_2_2=32'he0000000, coeff_in_3_2=32'h10000000 , coeff_out_1_2=32'he0447f31, coeff_out_2_2=32'h0fbbe417;
//wire signed [31:0] coeff_in_1_3=32'h10000000, coeff_in_2_3=32'he0000000, coeff_in_3_3=32'h10000000, coeff_out_1_3=32'he014790c, coeff_out_2_3=32'h0febca88;
// ... Khai bÃ¡o giÃ¡ trá» thá»±c táº¿ cho cÃ¡c há» sá» cá»§a má»i stage

// Káº¿t ná»i nhiá»u stages
wire signed [15:0] stage_outputs[4:0];

// Ãp dá»¥ng gain vÃ o data_in trÆ°á»c khi nÃ³ Äi qua cÃ¡c stages cá»§a bá» lá»c

// Khá»i táº¡o cÃ¡c stages cá»§a bá» lá»c vá»i data_in ÄÃ£ ÄÆ°á»£c Äiá»u chá»nh

IIR_fillter #(
  .DATA_BIT_NUM(DATA_BIT_NUM)
) biquad_1(
	.clk(clk), 
	.rst_n(rst), 
	.data_in(data_in), 
	.data_out(stage_outputs[0]),
	.coeff_in_1(coeff_in_1),
	.coeff_in_2(coeff_in_2),
	.coeff_in_3(coeff_in_3),
	.coeff_out_1(coeff_out_1),
	.coeff_out_2(coeff_out_2)
);
IIR_fillter #(
  .DATA_BIT_NUM(DATA_BIT_NUM)
) biquad_2(
	.clk(clk), 
	.rst_n(rst), 
	.data_in(stage_outputs[0]), 
	.data_out(stage_outputs[1]),
	.coeff_in_1(coeff_in_1_1),
	.coeff_in_2(coeff_in_2_1),
	.coeff_in_3(coeff_in_3_1),
	.coeff_out_1(coeff_out_1_1),
	.coeff_out_2(coeff_out_2_1)
);

// Äáº§u ra cá»§a bá» lá»c chÃ­nh lÃ  Äáº§u ra cá»§a stage cuá»i cÃ¹ng
assign data_out = stage_outputs[1];

endmodule
`timescale 1ns / 1ps

module testbench_iir_sum;

    // Parameters
    parameter DATA_BIT_NUM = 16;
    parameter SAMPLES = 1024;
    integer i;
    reg [DATA_BIT_NUM-1:0] data_array [0:SAMPLES-1];

    // Inputs
    reg clk;
    reg rst;
    reg signed [15:0] data_in;

    // Outputs
    wire signed [15:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    iir_sum uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a clock with a period of 10 ns
    end

    // Initial Conditions and Stimuli
    initial begin
        // Initialize Inputs
        rst = 1;        // Start with reset asserted
        data_in = 0;    // Default input

        #20 rst = 0;    // Release reset
        #20 rst = 1;    // Assert reset

        // Load input data from file
        $readmemb("sin_noise.txt", data_array);
        for (i = 0; i < SAMPLES; i = i + 1) begin
            @ (posedge clk);
            data_in = data_array[i];
        end

        // Complete the simulation
        $finish;
    end

    // Monitor changes and display them
    initial begin
        $monitor("At time %t, input = %d, output = %d", $time, data_in, data_out);
    end

endmodule
