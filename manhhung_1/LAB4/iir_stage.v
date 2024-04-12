module iir_stage(
    input wire clk,
    input wire rst,
    input wire signed [15:0] gain,       // Đầu vào của gain
    input wire signed [15:0] data_in,    // Đầu vào của bộ lọc
    output wire signed [15:0] data_out   // Đầu ra của bộ lọc
);
parameter DATA_BIT_NUM = 16;
// Các hệ số bộ lọc cho từng stage
wire signed [31:0] coeff_in_1=32'h000000bb, coeff_in_2=32'h00000176, coeff_in_3=32'h000000bb, coeff_out_1=32'he173bc58, coeff_out_2=32'h0e978a34;
wire signed [31:0] coeff_in_1_1=32'h10000000 , coeff_in_2_1=32'h20000000, coeff_in_3_1=32'h10000000, coeff_out_1_1=32'he0b2286f, coeff_out_2_1=32'h0f5eec7e;
wire signed [31:0] coeff_in_1_2=32'h10000000, coeff_in_2_2=32'he0000000, coeff_in_3_2=32'h10000000 , coeff_out_1_2=32'he0447f31, coeff_out_2_2=32'h0fbbe417;
wire signed [31:0] coeff_in_1_3=32'h10000000, coeff_in_2_3=32'he0000000, coeff_in_3_3=32'h10000000, coeff_out_1_3=32'he014790c, coeff_out_2_3=32'h0febca88;
// ... Khai báo giá trị thực tế cho các hệ số của mỗi stage

// Kết nối nhiều stages
wire signed [15:0] stage_outputs[4:0];
wire signed [15:0] adjusted_data_in;

// Áp dụng gain vào data_in trước khi nó đi qua các stages của bộ lọc
assign adjusted_data_in = data_in * gain;

// Khởi tạo các stages của bộ lọc với data_in đã được điều chỉnh

IIR_fillter #(
  .DATA_BIT_NUM(DATA_BIT_NUM)
) biquad_1(
	.clk(clk), 
	.rst_n(rst), 
	.data_in(data_in), 
	.data_out(data_out),
	.coeff_in_1(coeff_in_1),
	.coeff_in_2(coeff_in_2),
	.coeff_in_3(coeff_in_3),
	.coeff_out_1(coeff_out_1),
	.coeff_out_2(coeff_out_2)
);
// Đầu ra của bộ lọc chính là đầu ra của stage cuối cùng
//assign data_out = stage_outputs[3];

endmodule