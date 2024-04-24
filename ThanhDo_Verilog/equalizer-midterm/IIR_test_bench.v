`timescale 1ns / 1ps

module iir_filter_tb;

parameter DATA_BIT_NUM = 16;
parameter SAMPLES = 1024; // Số lượng mẫu dữ liệu

reg clk, rst;
reg signed [DATA_BIT_NUM-1:0] data_in;
wire signed [DATA_BIT_NUM-1:0] data_out;
reg [DATA_BIT_NUM-1:0] data_array [0:SAMPLES-1]; // Mảng lưu trữ dữ liệu đọc từ file
integer i, file_output;

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
     // Mở file output.txt để ghi kết quả
    file_output = $fopen("output.txt", "w");


    // Đọc dữ liệu từ file .txt
    $readmemb("C:\THANHDO_LAB_Verilog\ThanhDo_Verilog\equalizer-midtermdata_file.txt", data_array);

    // Reset bộ lọc
    #100 rst = 0;

    // Đưa dữ liệu vào bộ lọc và ghi kết quả ra file
    for (i = 0; i < SAMPLES; i = i + 1) begin
        #20; // Giả sử mỗi mẫu cách nhau 20ns
        data_in = data_array[i];
        #10; // Đợi một khoảng thời gian cho đầu ra ổn định
        $fdisplay(file_output, "%h", data_out); // Ghi đầu ra ra file
    end

    #100; // Chờ một chút sau mẫu cuối cùng
    $fclose(file_output); // Đóng file
    $stop; // Dừng mô phỏng
end

// Định nghĩa xung clock
always #5 clk = ~clk; // Tạo xung clock với chu kỳ 10ns

endmodule
