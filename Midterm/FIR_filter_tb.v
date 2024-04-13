`timescale 1ns/1ps
module FIR_filter_tb();
parameter DATA_BIT_NUM = 16;
parameter DELAY_NUM = 64;
parameter SAMPLES = 1024;

reg clk, rst_n;
reg signed [DATA_BIT_NUM-1:0] filter_data_in;
wire signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] filter_data_out;
reg [DATA_BIT_NUM-1:0] data_in_array [0:SAMPLES-1];
integer i, j;

FIR_filter uut(
    .clk(clk),
    .rst_n(rst_n),
    .filter_data_in(filter_data_in),
    .filter_data_out(filter_data_out)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk; // Đảo trạng thái clock mỗi 10 time units
end

initial begin
    rst_n = 0; 
    filter_data_in = 0;
    i = 0;

    // Đọc dữ liệu từ file .txt
    $readmemb("D:/Verilog project/DigitalDesign/DigitalDesign/Midterm/noisy_signal.txt", data_in_array);

    #100 rst_n = 1;

    // Đưa dữ liệu từ file .txt vào bộ lọc
    for (i = 0; i < SAMPLES; i = i + 1) begin    
        for (j = 0; j <= DELAY_NUM; j = j + 1) @ (posedge clk);                                                                                                                                        
        filter_data_in = data_in_array[i];        
    end

    #100000 $finish;
end

endmodule