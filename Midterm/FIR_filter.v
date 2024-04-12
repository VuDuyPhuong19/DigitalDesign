module FIR_filter #(
	parameter DATA_BIT_NUM = 16,
	parameter COEFF_BIT_NUM = 16,
	parameter COUNT_BIT_NUM = 6
)(
	input clk,
	input rst_n,
	// input [COUNT_BIT_NUM-1:0] count,
	// input calculated,
	input signed [DATA_BIT_NUM-1:0] filter_data_in,
	output signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] filter_data_out
);

wire [COEFF_BIT_NUM-1:0] coeffs_in;
wire signed [DATA_BIT_NUM-1:0] data_delay_in;
wire [COUNT_BIT_NUM-1:0] count;
wire calculated;

counter counter(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated));

coeffs coeffs(.count(count), .coeffs_in(coeffs_in));

delay delay(.clk(clk), .rst_n(rst_n), .count(count), .calculated(calculated), .data_in(filter_data_in), .data_delay_in(data_delay_in));

mac mac(.clk(clk), .rst_n(rst_n), .calculated(calculated), .data_delay_in(data_delay_in), .coeffs(coeffs_in), .data_out(filter_data_out));

endmodule 


module FIR_filter_tb();
parameter DATA_BIT_NUM = 16;
parameter DELAY_NUM = 64;
parameter SAMPLES = 1024;

reg clk, rst_n;
reg signed [DATA_BIT_NUM-1:0] filter_data_in;
wire signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] filter_data_out;
reg [DATA_BIT_NUM-1:0] data_in_array [0:SAMPLES-1];
integer i, j;

// Khởi tạo instance của FIR_filter
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
    // Khởi tạo
    rst_n = 0; // Kích hoạt reset
    filter_data_in = 0;
    i = 0;

    // Đọc dữ liệu từ file .txt
    $readmemb("D:/Verilog project/DigitalDesign/DigitalDesign/Midterm/noisy_signal.txt", data_in_array);

    // Thực hiện reset trong thời gian ngắn
    #100 rst_n = 1;

    // Đưa dữ liệu từ file .txt vào bộ lọc
    for (i = 0; i < SAMPLES; i = i + 1) begin    
        for (j = 0; j <= DELAY_NUM; j = j + 1) @ (posedge clk);                                                                                                                                        
        filter_data_in = data_in_array[i];        
        // $writememb("memory_binary.txt", memory);
    end

    // Kết thúc mô phỏng
end

endmodule
