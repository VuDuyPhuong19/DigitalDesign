module iir_stage #(
    parameter DATA_BIT_NUM = 16
)(
    input wire clk,
    input wire rst_n,
    input wire signed [DATA_BIT_NUM-1:0] coeff_in_1,
    input wire signed [DATA_BIT_NUM-1:0] coeff_in_2,
    input wire signed [DATA_BIT_NUM-1:0] coeff_in_3,
    input wire signed [DATA_BIT_NUM-1:0] coeff_out_1,
    input wire signed [DATA_BIT_NUM-1:0] coeff_out_2,
    input wire signed [DATA_BIT_NUM-1:0] data_in,
    output wire signed [DATA_BIT_NUM-1:0] data_out
);
// Biến trạng thái lưu các giá trị trễ đầu vào và đầu ra
reg signed [DATA_BIT_NUM-1:0] x1 = 0, x2 = 0;
reg signed [DATA_BIT_NUM-1:0] y1 = 0, y2 = 0;

// Tính toán phần feedforward của IIR filter
wire signed [DATA_BIT_NUM-1:0] feedforward_part = (data_in * coeff_in_1) + (x1 * coeff_in_2) + (x2 * coeff_in_3);

// Tính toán phần feedback của IIR filter
wire signed [DATA_BIT_NUM-1:0] feedback_part = (y1 * coeff_out_1) + (y2 * coeff_out_2);

// Kết quả của stage là sự kết hợp của feedforward và feedback
wire signed [DATA_BIT_NUM-1:0] stage_result = feedforward_part - feedback_part;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        // Reset các thanh ghi khi nhận tín hiệu reset
        x1 <= 0; x2 <= 0;
        y1 <= 0; y2 <= 0;
    end else begin
        // Cập nhật các giá trị trễ đầu vào và đầu ra
        x2 <= x1; x1 <= data_in;
        y2 <= y1; y1 <= stage_result;
    end
end
// Đầu ra của stage này là kết quả của phép trừ giữa feedforward và feedback
assign data_out = stage_result;

endmodule