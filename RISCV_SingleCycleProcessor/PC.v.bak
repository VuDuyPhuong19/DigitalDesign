module PC(
    input [9:0] address,
    output reg [9:0] next_address,
    input clk,
    input rst_n
);
always @(posedge clk or negedge rst_n ) begin
    if(~rst_n) begin
        next_address<=0;
    end
    else begin
        next_address<=address;
    end
end
endmodule