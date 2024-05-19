module PC #(
    parameter PC_WIDTH = 32
)(
    input clk,
    input rst_n,
    input [PC_WIDTH-1:0] pc,
    output reg [PC_WIDTH-1:0] next_pc
);

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        next_pc <= 32'b0;
    end
    else begin
        next_pc <= pc;
    end
end
endmodule