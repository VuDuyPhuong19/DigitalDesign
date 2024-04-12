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
	#20 data_delay_in = 16'b1000000011100000;
	coeffs = 16'b0001000001000101;
	calculated = 0;
	#20 data_delay_in = 16'b0000001111100000;
	coeffs = 16'b0000000001000101;
	calculated = 0;
	#20 data_delay_in = 16'b0000101011100000;
	coeffs = 16'b0000001001000101;
	calculated = 0;
	#20 data_delay_in = 16'b0010101011100000;
	coeffs = 16'b0000001001001101;
	calculated = 0;
	#20 data_delay_in = 16'b0000111011100000;
	coeffs = 16'b0000101001000101;
	calculated = 1;		
	#100 $finish;
end

// initial begin
//     rst_n = 0;
//     #10 rst_n = 1; // Đảm bảo reset đủ lâu

//     calculated = 0;
// //    #20; // Đợi một khoảng thời gian
//     @(posedge clk);
//     data_delay_in = 16'b1000000011100000;
//     coeffs = 16'b0001000001000101;
//     @(posedge clk);
//     calculated = 1;
//     #1000 $finish; // Kết thúc mô phỏng sau một khoảng thời gian
// end

endmodule