
module iir_filter_5tabs(
    input wire clk,
    input wire rst,
    input wire signed [15:0] gain,       // Đầu vào của gain
    input wire signed [15:0] data_in,    // Đầu vào của bộ lọc
    output wire signed [15:0] data_out   // Đầu ra của bộ lọc
);

// Các hệ số bộ lọc cho từng stage
wire signed [15:0] coeff_in_1, coeff_in_2, coeff_in_3, coeff_out_1, coeff_out_2;
// ... Khai báo giá trị thực tế cho các hệ số của mỗi stage

// Kết nối nhiều stages
wire signed [15:0] stage_outputs[4:0];
wire signed [15:0] adjusted_data_in;

// Áp dụng gain vào data_in trước khi nó đi qua các stages của bộ lọc
assign adjusted_data_in = data_in * gain;

// Khởi tạo các stages của bộ lọc với data_in đã được điều chỉnh
iir_stage stage1(.clk(clk), .rst_n(rst), .data_in(adjusted_data_in), 
 .data_out(stage_outputs[0]));

iir_stage stage2(.clk(clk), .rst_n(rst), .data_in(stage_outputs[0]),
 .data_out(stage_outputs[1]));
 
iir_stage stage3(.clk(clk), .rst_n(rst), .data_in(stage_outputs[1]),
 .data_out(stage_outputs[2]));

iir_stage stage4(.clk(clk), .rst_n(rst), .data_in(stage_outputs[2]), 
 .data_out(stage_outputs[3]));

iir_stage stage5(.clk(clk), .rst_n(rst), .data_in(stage_outputs[3]),
 .data_out(stage_outputs[4]));

// Đầu ra của bộ lọc chính là đầu ra của stage cuối cùng
assign data_out = stage_outputs[4];

endmodule