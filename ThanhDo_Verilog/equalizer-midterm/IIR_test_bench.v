`timescale 1ns / 1ps

module iir_filter_tb;

parameter DATA_BIT_NUM = 16;
parameter SAMPLES = 1024; // Số lượng mẫu dữ liệu
reg clk, rst;
reg signed [DATA_BIT_NUM-1:0] data_in;
wire signed [DATA_BIT_NUM-1:0] data_out;
reg [DATA_BIT_NUM-1:0] data_array [0:SAMPLES-1]; // Mảng lưu trữ dữ liệu đọc từ file
integer i;

// Khởi tạo instance của bộ lọc IIR
iir_filter_5tabs #(.DATA_BIT_NUM(DATA_BIT_NUM)) iir_filter (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out)
);

// Định nghĩa chu kỳ clock
always #10 clk = ~clk;

// Khối thực hiện việc test
initial begin
    // Khởi tạo
    clk = 0;
    rst = 1;
    data_in = 0;
    i = 0;

    // Đọc dữ liệu từ file .txt
    $readmemb("C:\THANHDO_LAB_Verilog\ThanhDo_Verilog\equalizer-midtermdata_file.txt", data_array);

    // Reset bộ lọc
    #100 rst = 0;

    // Đưa dữ liệu từ file .txt vào bộ lọc
    for (i = 0; i < SAMPLES; i = i + 1) begin
        @ (posedge clk);
        data_in = data_array[i];
    end

    // Kết thúc mô phỏng
    #1000;
    $stop;
end

endmodule
