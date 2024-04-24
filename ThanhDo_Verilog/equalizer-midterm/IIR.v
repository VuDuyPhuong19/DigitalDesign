module IIR
#(
    parameter order = 2,
    parameter word_size_in = 16,  // Số bit đầu vào
    parameter word_size_coeff = 16,  // Số bit cho hệ số
    parameter word_size_out = 16  // Số bit đầu ra
) (
    input clk,
    input rst_n,
    input [word_size_in-1:0] data_in,
    output reg [word_size_in-1:0] data_out 
);

// Các hệ số bộ lọc (Đã sửa đổi để phù hợp với định dạng Q2.14)
parameter signed [word_size_coeff-1:0] b0 = 16'sd0, b1 = 16'sd1, b2 = 16'sd0;
parameter signed [word_size_coeff-1:0] a1 = -16'sd31869, a2 = 16'sd15550;

// Mảng để lưu giữ các mẫu trước đó
reg signed [word_size_in-1:0] sample_in [0:order];
reg signed [word_size_in-1:0] sample_out [0:order];

// Biến trung gian để giữ kết quả của phép nhân có độ rộng tăng lên
wire signed [word_size_coeff-1:0] mult_in;
wire signed [word_size_coeff-1:0] mult_out;

integer k;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (k = 0; k <= order; k = k + 1) begin
            sample_in[k] <= 0;
            sample_out[k] <= 0;
        end
        data_out <= 0;
    end else begin
        // Cập nhật các mẫu
        sample_in[1] <= sample_in[0];
        sample_in[0] <= data_in;
        
        // Cập nhật mẫu ra và kết quả đầu ra
        sample_out[1] <= sample_out[0];
        sample_out[0] <= mult_in - mult_out; // Đưa kết quả đã làm tròn vào mẫu ra
        data_out <= sample_out[0];
    end
end

assign mult_in = (($signed(b0) * $signed(data_in)) + 
                  ($signed(b1) * $signed(sample_in[1])) + 
                  ($signed(b2) * $signed(sample_in[2]))) >>> 14;
assign mult_out = (($signed(a1) * $signed(sample_out[1])) + 
                   ($signed(a2) * $signed(sample_out[2]))) >>> 14;

endmodule

module IIR_filter_tb();
parameter DATA_BIT_NUM = 16;
parameter SAMPLES = 1024;

reg clk, rst_n;
reg signed [DATA_BIT_NUM-1:0] filter_data_in;
wire signed [DATA_BIT_NUM-1:0] filter_data_out;
reg [DATA_BIT_NUM-1:0] data_in_array [0:SAMPLES-1];
integer i;


IIR uut(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(filter_data_in),
    .data_out(filter_data_out)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk; // Äáº£o tráº¡ng thÃ¡i clock má»i 10 time units
end

initial begin
    // Khá»i táº¡o
    rst_n = 0; // KÃ­ch hoáº¡t reset
    filter_data_in = 0;
    i = 0;

    // Äá»c dá»¯ liá»u tá»« file .txt
    $readmemb("C:/THANHDO_LAB_Verilog/DigitalDesign/ThanhDo_Verilog/equalizer-midterm/sin_noise.txt", data_in_array);

    // Thá»±c hiá»n reset trong thá»i gian ngáº¯n
    #10 rst_n = 1;

    // ÄÆ°a dá»¯ liá»u tá»« file .txt vÃ o bá» lá»c
    for (i = 0; i < SAMPLES; i = i + 1) begin
        @ (posedge clk);
        filter_data_in = data_in_array[i];
    end

    // Káº¿t thÃºc mÃ´ phá»ng
    #1000;
    $finish;
end

endmodule


