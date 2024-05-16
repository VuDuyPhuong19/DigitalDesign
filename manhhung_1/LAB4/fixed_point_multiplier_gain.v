module fixed_point_multiplier(
    input signed [15:0] int16,       // Số nguyên 16-bit
    input [3:0] real4,               // Số thực 4-bit
    output signed [15:0] result      // Kết quả số nguyên 16-bit
);
    // Mở rộng số thực 4-bit ra thành 16-bit
    wire signed [15:0] extended_real4 = {{11{real4[3]}}, real4[3:0], 2'b00};

    // Thực hiện phép nhân, sau đó dịch phải để điều chỉnh cho phần thập phân
    assign result = (int16 * extended_real4) >>> 2;

endmodule
`timescale 1ns / 1ps

module tb_fixed_point_multiplier;

    // Định nghĩa các biến đầu vào và đầu ra
    reg signed [15:0] int16;
    reg [3:0] real4;
    wire signed [15:0] result;

    // Khởi tạo module cần kiểm tra
    fixed_point_multiplier_gain uut (
        .int16(int16),
        .real4(real4),
        .result(result)
    );

    // Khởi tạo các giá trị đầu vào và quan sát đầu ra
    initial begin
        // Khởi tạo đầu vào
        int16 = 0;
        real4 = 4'b0000;
        #10; // Chờ 10 ns

        // Test case 1: Nhân với số dương nhỏ
        int16 = 16'd1000;     // Số nguyên 16-bit
        real4 = 4'b0101;      // Số thực 4-bit: +1.01 (định dạng dấu cố định)
        #10; // Chờ 10 ns

        // Test case 2: Nhân với số âm
        int16 = 16'd1000;
        real4 = 4'b1101;      // Số thực 4-bit: -1.01 (định dạng dấu cố định)
        #10; // Chờ 10 ns

        // Test case 3: Kiểm tra với số nguyên âm
        int16 = -16'd1000;
        real4 = 4'b0101;
        #10; // Chờ 10 ns

        // Test case 4: Kiểm tra với giá trị thực âm và nguyên âm
        int16 = -16'd1000;
        real4 = 4'b1101;
        #10; // Chờ 10 ns

        // Kết thúc simulation
        $finish;
    end

    // Theo dõi kết quả đầu ra
    initial begin
        $monitor("Time = %t, Input int16 = %d, Input real4 = %b, Output result = %d", 
                 $time, int16, real4, result);
    end

endmodule
