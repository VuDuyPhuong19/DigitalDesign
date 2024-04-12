// module mac #(
// 	parameter DATA_BIT_NUM = 16,
// 	parameter COEFF_BIT_NUM = 16
// )(
// 	input clk,
// 	input rst_n,
// 	input calculated,
// 	input signed [DATA_BIT_NUM-1:0] data_delay_in,
// 	input signed [COEFF_BIT_NUM-1:0] coeffs,
// 	output signed [DATA_BIT_NUM+DATA_BIT_NUM-1:0] data_out
// );

// wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-3:0] product;
// wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] temp_product = 0;
// reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] accumulator;
// wire sign_bit = 0;

// // Multiplier
// assign product = data_delay_in[DATA_BIT_NUM-2:0] * coeffs[COEFF_BIT_NUM-2:0];
// // coeff = sign(1) integer(1) . fraction(14)
// // data_delay)in = sign(1) value(15)
// // multiplier mul(.A(data_delay_in[DATA_BIT_NUM-2:0]), .B(coeffs[COEFF_BIT_NUM-2:0]), .product(product));

// assign sign_bit = (data_delay_in[DATA_BIT_NUM-1] & coeffs[COEFF_BIT_NUM-1]) ? 1 : 0;
// assign temp_product = {sign_bit, product, 1'b0};

// // Accumulation
// always @(posedge clk or negedge rst_n) begin
// 	if (~rst_n) begin
// 		accumulator <= 0;
// 	end else if (calculated) begin
// 		accumulator <= accumulator + temp_product;
// 	end
// end

// // Đưa ra kết quả, có thể cần thêm logic để chỉnh định dạng kết quả
// assign data_out = accumulator[DATA_BIT_NUM+DATA_BIT_NUM-1:0];

// endmodule

module mac #(
    parameter DATA_BIT_NUM = 16,
    parameter COEFF_BIT_NUM = 16
)(
    input clk,
    input rst_n,
    input calculated,
    input signed [DATA_BIT_NUM-1:0] data_delay_in,
    input signed [COEFF_BIT_NUM-1:0] coeffs,
    output reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] data_out
);

wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] product;
reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] accumulator;

// Multiplier
assign product = calculated ? 0 : data_delay_in * coeffs; // Direct multiplication of signed inputs

// Accumulation
// Khối always cho tính toán product
// always @(posedge clk or negedge rst_n) begin
//     if (~rst_n) begin
//         product <= 0;  // Khởi tạo product
//     end else if (!calculated) begin
//         product <= data_delay_in * coeffs;  // Tính toán product mỗi khi không trong chế độ calculated
//     end
// end

// Khối always cho cập nhật accumulator
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        accumulator <= 0;  // Khởi tạo accumulator
    end else if (~calculated) begin
        accumulator <= accumulator + product;  // Cập nhật accumulator với product
    end else begin
        data_out <= accumulator;  // Chuyển giá trị accumulator sang data_out khi calculated
        accumulator <= 0;  // Reset accumulator sau khi đã chuyển giá trị
    end
end




endmodule