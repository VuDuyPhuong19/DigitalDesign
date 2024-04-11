module IIR_fillter #(
	parameter DATA_BIT_NUM = 16
)(
	input clk,
	input rst_n,
	input coeff_in_1,
	input coeff_in_2,
	input coeff_in_3,
	input coeff_out_1,
	input coeff_out_2,
	input signed [DATA_BIT_NUM-1:0] data_in,
	output wire signed [DATA_BIT_NUM-1:0] data_out
);
wire signed [DATA_BIT_NUM-1:0] delay_1_b;
wire signed [DATA_BIT_NUM-1:0] delay_2_b;
reg signed [DATA_BIT_NUM-1:0] delay_1_a;
reg signed [DATA_BIT_NUM-1:0] delay_2_a;
wire signed [DATA_BIT_NUM-1:0] data_in_coeff_1;
assign data_in_coeff_1=data_in*coeff_in_1;
wire signed [DATA_BIT_NUM-1:0] data_in_coeff_2;
assign data_in_coeff_2=data_in*coeff_in_2;
wire signed [DATA_BIT_NUM-1:0] data_in_coeff_3;
assign data_in_coeff_3=data_in*coeff_in_3;
wire signed [DATA_BIT_NUM-1:0] data_out_coeff_1;
assign data_out_coeff_1=data_out*coeff_out_1;
wire signed [DATA_BIT_NUM-1:0] data_out_coeff_2;
assign data_out_coeff_2=data_out*coeff_out_2;
assign delay_1_b=data_in_coeff_2+data_out_coeff_1+delay_2_a;
assign delay_2_b=data_in_coeff_3+data_out_coeff_2;
reg signed [DATA_BIT_NUM-1:0] delay_1;
reg signed [DATA_BIT_NUM-1:0] delay_2;
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
	delay_1_a=0;
	delay_2_a=0;
	end
	else begin
	delay_1_a<=delay_1_b;
	delay_2_a<=delay_2_b;
	end
end
assign data_out=delay_1_a+data_in_coeff_1;
endmodule 