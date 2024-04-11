module iir_stage(
    input wire clk,
    input wire rst,
    input wire signed [15:0] data_in,  // Đầu vào của stage này
    input wire signed [15:0] a1,       // Hệ số feedback
    input wire signed [15:0] a2,       // Hệ số feedback
    input wire signed [15:0] b0,       // Hệ số feedforward
    input wire signed [15:0] b1,       // Hệ số feedforward
    input wire signed [15:0] b2,       // Hệ số feedforward
    output wire signed [15:0] data_out // Đầu ra của stage này
);

reg signed [15:0] w0 = 0;  // Biến trạng thái
reg signed [15:0] w1 = 0;  // Biến trạng thái
reg signed [15:0] w2 = 0;  // Biến trạng thái

// Khối tính toán feedforward và feedback
wire signed [31:0] feedforward = b0 * data_in + b1 * w1 + b2 * w2;
wire signed [31:0] feedback = a1 * w1 + a2 * w2;
wire signed [31:0] stage_out = feedforward - feedback;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        w1 <= 0;
        w2 <= 0;
    end else begin
        w2 <= w1;  // Cập nhật các mẫu đầu vào trước đó
        w1 <= data_in - (feedback >> 15);  // Dịch về đúng tỷ lệ và trừ đi feedback
    end
end

// Cập nhật đầu ra từ stage này
assign data_out = stage_out >> 15;  // Dịch về đúng tỷ lệ để giữ đúng định dạng Q1.15

endmodule

module iir_filter_5tabs(
    input wire clk,
    input wire rst,
    input wire signed [15:0] data_in,  // Đầu vào của bộ lọc
    output wire signed [15:0] data_out // Đầu ra của bộ lọc
);

// Định nghĩa các hệ số cho mỗi stage - bạn cần thay thế bằng các giá trị thực tế
wire signed [15:0] a1, a2, b0, b1, b2;
// ...

// Kết nối nhiều stages
wire signed [15:0] stage_outputs[4:0];

iir_stage stage1(.clk(clk), .rst(rst), .data_in(data_in), /* Hệ số cho stage 1 */, .data_out(stage_outputs[0]));
iir_stage stage2(.clk(clk), .rst(rst), .data_in(stage_outputs[0]), /* Hệ số cho stage 2 */, .data_out(stage_outputs[1]));
iir_stage stage3(.clk(clk), .rst(rst), .data_in(stage_outputs[1]), /* Hệ số cho stage 3 */, .data_out(stage_outputs[2]));
iir_stage stage4(.clk(clk), .rst(rst), .data_in(stage_outputs[2]), /* Hệ số cho stage 4 */, .data_out(stage_outputs[3]));
iir_stage stage5(.clk(clk), .rst(rst), .data_in(stage_outputs[3]), /* Hệ số cho stage 5 */, .data_out(stage_outputs[4]));

// Đầu ra của bộ lọc chính là đầu ra của stage cuối cùng
assign data_out = stage_outputs[4];

endmodule
