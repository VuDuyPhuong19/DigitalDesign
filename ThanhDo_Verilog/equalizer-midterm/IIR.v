module IIR (data_in, clk,rat,data_out);
parameter order =  8;
parameter word_size_in=8;
parameter word_size_out=2*word_size_in;

//feedforward filter coeficient
parameter b0=8'd7, b1=8'd0, b2=8'd0;
//feedback filter 
parameter a1=8'd46, a2=8'd32, a3=8'd9;
// I/O declaration
output [word_size_out-1 :0] data_out; //the output of feedforward part
input [word_size_in-1:0] data_in;
input clk, rat;
// variable declaration
wire  [word_size_out-1 :0] data_feedforward;
wire [word_size_out-1 :0 ] data_feedback;
reg [word_size_in-1: 0] sample_in [1:order];
reg [word_size_in:0] sample_out [1:order];
integer  k;

assign data_feedforward=b0*data_in+ b1*sample_in[1]
+ b2*sample_in[2] + b3*sample_in[3] +b4*sample_in[4]
+ b5*sample_in[5]+ b6*sample_in[6] + b7*sample_in[7] + b8*sample_in[8];


assign data_feedback=a1*sample_out[1]
+ a2*sample_out[2] + a3*sample_out[3] +a4*sample_out[4]
+ a5*sample_out[5]+ a6*sample_out[6] + a7*sample_out[7] + a8*sample_out[8];

assign data_out=data_feedback+data_feedforward;

always @(posedge clk) begin
    if (rat)
    for(k=1; k<=order;k=k+1) begin   
        sample_in[k]<=0;
        sample_out[k]<=0;
    end
    else begin
        sample_in[1]<= data_in;
        sample_out[1]<=data_out[15:8]; // truncation operation
        for(k=1; k<=order;k=k+1) begin 
            sample_in[k]<=sample_in[k-1];
            sample_out[k]<=sample_out[k-1];
        end
    end
end
endmodule