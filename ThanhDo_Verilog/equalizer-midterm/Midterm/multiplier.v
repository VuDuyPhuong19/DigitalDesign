// module multiplier #(
//     parameter N = 4
// )(
//     input [N-1:0] A,
//     input [N-1:0] B,
//     output [2*N-1:0] product
// );

// reg [2*N-1:0] temp_product;
// integer i;

// always @(A, B) begin
//     temp_product = 0;
//     for (i = 0; i < N; i = i + 1) begin
//         if (B[i]) temp_product = temp_product + (A << i);
//     end
// end

// assign product = temp_product;

// endmodule
// module multiplier #(
//     parameter N = 4
// )(
//     input [N-1:0] A,
//     input [N-1:0] B,
//     output [2*N-1:0] product
// );

// reg [2*N-1:0] temp_product;
// integer i;

// always @(A, B) begin
//     temp_product = 0;
//     for (i = 0; i < N; i = i + 1) begin
//         if (B[i]) temp_product = temp_product + (A << i);
//     end
// end

// assign product = temp_product;

// endmodule

module multiplier #(
    parameter N = 4
)(
    input [N-1:0] A,
    input [N-1:0] B,
    output [N+N-1:0] product
);

reg [N+N-1:0] temp_product;
integer i;

always @(A, B) begin
    temp_product = 0;
    for (i = 0; i < N; i = i + 1) begin
        if (B[i]) temp_product = temp_product + (A << i);
    end
end

assign product = temp_product;

endmodule


module multiplier_tb();
parameter N = 4;
reg [N-1:0] A;
reg [N-1:0] B;
wire [N+N-1:0] product;

multiplier uut(.A(A), .B(B), .product(product));

initial begin
	#10 A = 4'b1111;
	B = 4'b1111;
	#10
	$finish;
end

endmodule