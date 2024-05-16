module BinaryToBCD(
    input [7:0] binary,
    output reg [3:0] tens,
    output reg [3:0] ones
);

integer i;
always @(binary) begin
    tens = 0;
    ones = 0;
    for (i = 7; i >= 0; i = i - 1) begin
        // Trước khi thêm bit mới, kiểm tra và điều chỉnh
        if (tens >= 5)
            tens = tens + 3;
        if (ones >= 5)
            ones = ones + 3;
        
        // Dịch các BCD lên để nhường chỗ cho bit mới
        tens = tens << 1;
        tens[0] = ones[3];
        ones = ones << 1;
        ones[0] = binary[i];
    end
end

endmodule
