module mac #(
	parameter DATA_BIT_NUM = 16,
	parameter COEFF_BIT_NUM = 16
)(
	input clk,
	input rst_n,
	input calculated,
	input signed [DATA_BIT_NUM-1:0] data_delay_in,
	input signed [COEFF_BIT_NUM-1:0] coeffs,
	output signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] data_out
);

wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-3:0] product;
wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] temp_product;
reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] accumulator;
wire sign_bit = 0;

// Multiplier
// product = data_delay_in * coeffs;
// coeff = sign(1) integer(1) . fraction(14)
// data_delay)in = sign(1) value(15)
multiplier mul(.A(data_delay_in[DATA_BIT_NUM-2:0]), .B(coeffs[COEFF_BIT_NUM-2:0]), .product(product));
assign sign_bit = (data_delay_in[DATA_BIT_NUM-1] & coeffs[COEFF_BIT_NUM-1]) ? 1 : 0;
assign temp_product = {sign_bit, product, 1'b0};


// // Accumulation
// always @(posedge clk or negedge rst_n) begin
// 	if (~rst_n) begin
// 		accumulator <= 0;
// 	end 
// 	else begin
// 		if (calculated) begin
// 			accumulator <= 0;
// 		end
// 		else begin
// 			accumulator <= accumulator + temp_product;
// 		end
// 	end
// end

// // Đưa ra kết quả, có thể cần thêm logic để chỉnh định dạng kết quả
// assign data_out = calculated ? accumulator : 32'b0000000000000000;
// // assign data_out = accumulator;
reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] last_valid_acc;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		accumulator <= 0;
		last_valid_acc <= 0;
	end 
	else begin
		if (calculated) begin
			last_valid_acc <= accumulator; // Lưu giá trị trước khi reset
			accumulator <= 0;
		end
		else begin
			accumulator <= accumulator + temp_product;
		end
	end
end

assign data_out = calculated ? last_valid_acc : 32'b0000000000000000;

// [DATA_BIT_NUM-1:0]
endmodule

module mac_tb();
parameter DATA_BIT_NUM = 16;
parameter COEFF_BIT_NUM = 16;
reg clk, rst_n, calculated;
reg signed [DATA_BIT_NUM-1:0] data_delay_in;
reg signed [COEFF_BIT_NUM-1:0] coeffs;
wire signed [DATA_BIT_NUM-1:0] data_out;

mac uut(.clk(clk), .rst_n(rst_n), .calculated(calculated), .data_delay_in(data_delay_in), .coeffs(coeffs), .data_out(data_out));

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	rst_n = 0;
	#10 rst_n = 1;
	#10 data_delay_in = 16'b1000000011100000;
	coeffs = 16'b0000000000000000;
	calculated = 1;
	#10 $finish;
end

endmodule

