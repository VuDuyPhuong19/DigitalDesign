module FIR_filter_parallel #(
	parameter DATA_BIT_NUM = 16,
	parameter COEFF_BIT_NUM = 16,
	parameter NUMTABS = 64
)(
	input clk,
	input rst_n,
	input signed [DATA_BIT_NUM-1:0] filter_data_in,
	output reg signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] filter_data_out
);

reg [COEFF_BIT_NUM-1:0] coeffs [0:NUMTABS-1];
reg [DATA_BIT_NUM-1:0] temp_filter_data_in;
wire [DATA_BIT_NUM+DATA_BIT_NUM-1:0] product [0:NUMTABS-1];

initial begin
	coeffs[0] =  16'b0000000000011110; 
	coeffs[1] =  16'b0000000000100100;
	coeffs[2] =  16'b0000000000101010;
	coeffs[3] =  16'b0000000000110010;
	coeffs[4] =  16'b0000000001000000;
	coeffs[5] =  16'b0000000001010000;
	coeffs[6] =  16'b0000000001100100;
	coeffs[7] =  16'b0000000001111100;
	coeffs[8] =  16'b0000000010011010;
	coeffs[9] =  16'b0000000010111100;
	coeffs[10] = 16'b0000000011100010;
	coeffs[11] = 16'b0000000100001100;
	coeffs[12] = 16'b0000000100111010;
	coeffs[13] = 16'b0000000101101100;
	coeffs[14] = 16'b0000000110100010;
	coeffs[15] = 16'b0000000111011100;
	coeffs[16] = 16'b0000001000010110;
	coeffs[17] = 16'b0000001001010010;
	coeffs[18] = 16'b0000001010010000;
	coeffs[19] = 16'b0000001011001110;
	coeffs[20] = 16'b0000001100001100;
	coeffs[21] = 16'b0000001101001000;
	coeffs[22] = 16'b0000001110000010;
	coeffs[23] = 16'b0000001110111000;
	coeffs[24] = 16'b0000001111101010;
	coeffs[25] = 16'b0000010000011010;
	coeffs[26] = 16'b0000010001000010;
	coeffs[27] = 16'b0000010001100110;
	coeffs[28] = 16'b0000010010000010;
	coeffs[29] = 16'b0000010010011000;
	coeffs[30] = 16'b0000010010100110;
	coeffs[31] = 16'b0000010010101110;
	coeffs[32] = 16'b0000010010101110;
	coeffs[33] = 16'b0000010010100110;
	coeffs[34] = 16'b0000010010011000;
	coeffs[35] = 16'b0000010010000010;
	coeffs[36] = 16'b0000010001100110;
	coeffs[37] = 16'b0000010001000010;
	coeffs[38] = 16'b0000001000001101;
	coeffs[39] = 16'b0000001111101010;
	coeffs[40] = 16'b0000001110111000;
	coeffs[41] = 16'b0000001110000010;
	coeffs[42] = 16'b0000001101001000;
	coeffs[43] = 16'b0000001100001100;
	coeffs[44] = 16'b0000001011001110;
	coeffs[45] = 16'b0000001010010000;
	coeffs[46] = 16'b0000001001010010;
	coeffs[47] = 16'b0000001000010110;
	coeffs[48] = 16'b0000000111011100;
	coeffs[49] = 16'b0000000110100010;
	coeffs[50] = 16'b0000000101101100;
	coeffs[51] = 16'b0000000100111010;
	coeffs[52] = 16'b0000000100001100;
	coeffs[53] = 16'b0000000011100010;
	coeffs[54] = 16'b0000000010111100;
	coeffs[55] = 16'b0000000010011010;
	coeffs[56] = 16'b0000000001111100;
	coeffs[57] = 16'b0000000001100100;
	coeffs[58] = 16'b0000000001010000;
	coeffs[59] = 16'b0000000001000000;
	coeffs[60] = 16'b0000000000110010;
	coeffs[61] = 16'b0000000000101010;
	coeffs[62] = 16'b0000000000100100;
	coeffs[63] = 16'b0000000000011110;
end

always @ (posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		filter_data_out <= 0;
	end
	else begin
		temp_filter_data_in <= filter_data_in;
	end
end

generate
	genvar i;
	for (i = 0; i < NUMTABS; i = i + 1) begin : product_loop
		multiplier mul(.A(temp_filter_data_in), .B(coeffs[i]), .product(product[i]));
	end
endgenerate


integer j;
always @ (posedge clk or negedge rst_n) begin
		filter_data_out <= product[0] + product[1] + product[2] + product[3] + product[4] + product[5] + product[6] + product[7] + product[8] + product[9] + product[10] + product[11] + product[12] + product[13] + product[14] + product[15] + product[16] + product[17] + product[18] + product[19] + product[20] + product[21] + product[22] + product[23] + product[24] + product[25] + product[26] + product[27] + product[28] + product[29] + product[30] + product[31] + product[32] + product[33] + product[34] + product[35] + product[36] + product[37] + product[38] + product[39] + product[40] + product[41] + product[42] + product[43] + product[44] + product[45] + product[46] + product[47] + product[48] + product[49] + product[50] + product[51] + product[52] + product[53] + product[54] + product[55] + product[56] + product[57] + product[58] + product[59] + product[60] + product[61] + product[62] + product[63];
end

endmodule

`timescale 1ns/1ps
module FIR_filter_parallel_tb();
parameter DATA_BIT_NUM = 16;
parameter DELAY_NUM = 64;
parameter SAMPLES = 1024;

reg clk, rst_n;
reg signed [DATA_BIT_NUM-1:0] filter_data_in;
wire signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] filter_data_out;
reg [DATA_BIT_NUM-1:0] data_in_array [0:SAMPLES-1];
integer i, j;

// Khởi tạo instance của FIR_filter
FIR_filter_parallel uut(
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
    $readmemb("D:/Verilog project/DigitalDesign/DigitalDesign/FIR_filter_parallel/noisy_signal.txt", data_in_array);

    // Thực hiện reset trong thời gian ngắn
    #20 rst_n = 1;

    // Đưa dữ liệu từ file .txt vào bộ lọc
    for (i = 0; i < SAMPLES; i = i + 1) begin                                                                                                                                       
        #20 filter_data_in = data_in_array[i];        
        // $writememb("memory_binary.txt", memory);
    end

    #100000 $finish;

    // Kết thúc mô phỏng
end

endmodule