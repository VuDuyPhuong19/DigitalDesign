module mux_2 #(
    parameter MUX_DATA_WIDTH = 32
)(
    input [MUX_DATA_WIDTH-1:0] A,
    input [MUX_DATA_WIDTH-1:0] B,
    input control,
    output [MUX_DATA_WIDTH-1:0] mux_out
);
assign mux_out = (~control) ? A : B;

endmodule