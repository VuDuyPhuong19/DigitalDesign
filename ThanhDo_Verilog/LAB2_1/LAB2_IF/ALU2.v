module ALU2(
    input [3:0] A, B, // Đầu vào 4 bit
    input [1:0] control, // Điều khiển mở rộng: 00 cho cộng, 01 cho trừ, 10 cho AND, 11 cho OR
    output reg [4:0] result // Kết quả 5 bit
);

always @(A, B, control) begin
    if (control == 2'b00)
        result = A + B; // Cộng
    else if (control == 2'b01)
        result = A - B; // Trừ
    else if (control == 2'b10)
        result = A & B; // AND
    else if (control == 2'b11)
        result = A | B; // OR
	 else result = A | B; // OR
end

endmodule
