module MUX_PETCH(
    input [9:0] Sum,
    input [9:0] add_normal,
    input [1:0] control,
    output [9:0] address
);
assign address=(~control)?add_normal:Sum;
endmodule