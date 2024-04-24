module IIR_fillter #(
	parameter DATA_BIT_NUM = 16,
	parameter DATA_BIT_NUMK = 48
)(
	input clk,
	input rst_n,
	input signed [31:0] coeff_in_1,
	input signed [31:0] coeff_in_2,
	input signed [31:0] coeff_in_3,
	input signed [31:0] coeff_out_1,
	input signed [31:0] coeff_out_2,
	input signed [DATA_BIT_NUM-1:0] data_in,
	output wire signed [DATA_BIT_NUM-1:0] data_out
);
reg signed [DATA_BIT_NUMK-1:0] delay_1_b;
reg signed [DATA_BIT_NUMK-1:0] delay_2_b;
reg signed [DATA_BIT_NUMK-1:0] delay_1_a;
reg signed [DATA_BIT_NUMK-1:0] delay_2_a;
wire signed [DATA_BIT_NUMK-1:0] data_in_coeff_1;
wire signed [DATA_BIT_NUMK-1:0] data_in_coeff_2;
wire signed [DATA_BIT_NUMK-1:0] data_in_coeff_3;
wire signed [DATA_BIT_NUMK-1:0] data_out_coeff_1;
wire signed [DATA_BIT_NUMK-1:0] data_out_coeff_2;
wire signed [DATA_BIT_NUMK-1:0] data_out_pre;
multiply_fixed_point multi(
	.integer_input(data_in),
	.real_input(coeff_in_1),
	.result(data_in_coeff_1)
);
multiply_fixed_point multi_1(
	.integer_input(delay_1_b),
	.real_input(coeff_in_2),
	.result(data_in_coeff_2)
);
multiply_fixed_point multi_2(
	.integer_input(delay_2_b),
	.real_input(coeff_in_3),
	.result(data_in_coeff_3)
);
multiply_fixed_point multi_3(
	.integer_input(delay_1_a),
	.real_input(coeff_out_1),
	.result(data_out_coeff_1)
);
multiply_fixed_point multi_4(
	.integer_input(delay_2_a),
	.real_input(coeff_out_2),
	.result(data_out_coeff_2)
);
initial begin 

end
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
	delay_1_b<=0;
	delay_2_b<=0;
    delay_1_a<=0;
	delay_2_a<=0;

	end
	else begin
	delay_1_b<=data_in;
	delay_2_b<=delay_1_b;

	delay_2_a<=delay_1_a;
    delay_1_a<=data_out_pre;
	end
end
assign data_out_pre= data_in_coeff_1+ data_in_coeff_2 + data_in_coeff_3 - data_out_coeff_1 -data_out_coeff_2;
wire signed [15:0] data_out_pre_1 = data_out_pre[47:28] + {{15{data_out_pre[27]}}, data_out_pre[27]};
assign data_out=data_out_pre_1;
endmodule 