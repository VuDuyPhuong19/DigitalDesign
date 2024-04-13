module mac #(
    parameter DATA_BIT_NUM = 16,
    parameter COEFF_BIT_NUM = 16
)(
    input clk,
    input rst_n,
    input calculated,
    input signed [DATA_BIT_NUM-1:0] data_delay_in,
    input signed [COEFF_BIT_NUM-1:0] coeffs,
    output reg signed [DATA_BIT_NUM-1:0] data_out
);

wire signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] product;
reg signed [DATA_BIT_NUM+COEFF_BIT_NUM-1:0] accumulator;

// Multiplier
assign product = calculated ? 0 : data_delay_in * coeffs; 

// Accumulator
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        accumulator <= 0;  
    end else if (~calculated) begin
        accumulator <= accumulator + product;  
    end else begin
        data_out <= accumulator[DATA_BIT_NUM+COEFF_BIT_NUM-1:DATA_BIT_NUM];  
        accumulator <= 0;  
    end
end




endmodule