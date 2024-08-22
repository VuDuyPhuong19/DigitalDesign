// one_cycle_mutiplier

module multiplier
(
    input           clk_i,
    input           rst_ni,
    input           start_i,
    input  [31:0]   operand_a_i,
    input  [31:0]   operand_b_i,
    input  [1:0]    func_i,
    output reg [31:0] result_o,
    output reg       valid_o
);

localparam IDLE        = 3'b000;
localparam EXECUTE     = 3'b001;
localparam COMPLETE    = 3'b010;

reg [2:0] state_q, state_d;
reg [63:0] product_q, product_d;
reg [31:0] a_reg, b_reg;
reg sign_a, sign_b;

always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        state_q <= IDLE;
        product_q <= 64'b0;
    end else begin
        state_q <= state_d;
        product_q <= product_d;
    end
end

always @(*) begin
    state_d = state_q;
    product_d = product_q;
    valid_o = 1'b0;
    result_o = 32'b0;

    case (state_q)
        IDLE: begin
            if (start_i) begin
                a_reg = operand_a_i;
                b_reg = operand_b_i;

                // Kiểm tra dấu của các toán hạng
                sign_a = (func_i != 2'b10) && operand_a_i[31];
                sign_b = (func_i == 2'b00 || func_i == 2'b01) && operand_b_i[31];

                // Tạo giá trị tuyệt đối của các toán hạng nếu cần
                if (sign_a) a_reg = -operand_a_i;
                if (sign_b) b_reg = -operand_b_i;

                state_d = EXECUTE;
            end
        end

        EXECUTE: begin
            // Tính toán sản phẩm 64-bit
            case (func_i)
                2'b00: product_d = $signed(a_reg) * $signed(b_reg);   // MUL
                2'b01: product_d = $signed(a_reg) * $signed(b_reg);   // MULH
                2'b10: product_d = $unsigned(a_reg) * $unsigned(b_reg); // MULHU
                2'b11: product_d = $signed(a_reg) * $unsigned(b_reg);  // MULHSU
            endcase

            // Điều chỉnh dấu nếu cần (cho MUL và MULH)
            if ((sign_a ^ sign_b)) begin
                product_d = -product_d;
            end

            state_d = COMPLETE;
        end

        COMPLETE: begin
            // Lựa chọn kết quả đầu ra dựa trên loại phép toán
            case (func_i)
                2'b00: result_o = product_d[31:0];   // MUL: phần thấp của sản phẩm
                2'b01: result_o = product_d[63:32];  // MULH: phần cao của sản phẩm
                2'b10: result_o = product_d[63:32];  // MULHU: phần cao của sản phẩm không dấu
                2'b11: result_o = product_d[63:32];  // MULHSU: phần cao của sản phẩm với a có dấu, b không dấu
            endcase
            valid_o = 1'b1;
            state_d = IDLE;
        end
    endcase
end

endmodule

// 32_cycles_mutiplier

// module multiplier (
//     input           clk_i,
//     input           rst_ni,
//     input           start_i,        // Tín hiệu bắt đầu phép nhân
//     input  [31:0]   operand_a_i,     // Toán hạng 1
//     input  [31:0]   operand_b_i,     // Toán hạng 2
//     input  [1:0]    func_i,          // Hàm chọn (00: MUL, 01: MULH, 10: MULHU, 11: MULHSU)
//     output reg [31:0] result_o,      // Kết quả đầu ra
//     output reg       valid_o         // Tín hiệu hoàn thành phép nhân
// );

// localparam IDLE = 2'b00;
// localparam CALC = 2'b01;
// localparam COMPLETE = 2'b10;

// reg [1:0]  state_q, state_d;
// reg [63:0] product_q, product_d;
// reg [31:0] a_q, a_d;
// reg [31:0] b_q, b_d;
// reg [5:0]  count_q, count_d;
// reg sign_a, sign_b;

// // Thanh ghi trạng thái
// always @(posedge clk_i or negedge rst_ni) begin
//     if (!rst_ni) begin
//         state_q   <= IDLE;
//         product_q <= 64'b0;
//         a_q       <= 32'b0;
//         b_q       <= 32'b0;
//         count_q   <= 6'b0;
//     end else begin
//         state_q   <= state_d;
//         product_q <= product_d;
//         a_q       <= a_d;
//         b_q       <= b_d;
//         count_q   <= count_d;
//     end
// end

// // FSM và logic điều khiển
// always @(*) begin
//     // Mặc định các giá trị
//     state_d   = state_q;
//     product_d = product_q;
//     a_d       = a_q;
//     b_d       = b_q;
//     count_d   = count_q;
//     valid_o   = 1'b0;
//     result_o  = 32'b0;

//     case (state_q)
//         IDLE: begin
//             if (start_i) begin
//                 // Khởi tạo các giá trị khi bắt đầu
//                 // case (func_i)
//                 //     2'b00, 2'b01: begin // MUL hoặc MULH
//                 //         sign_a = operand_a_i[31];
//                 //         sign_b = operand_b_i[31];
//                 //         a_d    = sign_a ? -operand_a_i : operand_a_i;
//                 //         b_d    = sign_b ? -operand_b_i : operand_b_i;
//                 //     end
//                 //     2'b10: begin // MULHU
//                 //         sign_a = 1'b0;
//                 //         sign_b = 1'b0;
//                 //         a_d    = operand_a_i;
//                 //         b_d    = operand_b_i;
//                 //     end
//                 //     2'b11: begin // MULHSU
//                 //         sign_a = operand_a_i[31];
//                 //         sign_b = 1'b0;
//                 //         a_d    = sign_a ? -operand_a_i : operand_a_i;
//                 //         b_d    = operand_b_i;
//                 //     end
//                 // endcase

//                 a_d = operand_a_i;
//                 b_d = operand_b_i;

//                 // Kiểm tra dấu của các toán hạng
//                 sign_a = (func_i != 2'b10) && operand_a_i[31];
//                 sign_b = (func_i == 2'b00 || func_i == 2'b01) && operand_b_i[31];

//                 // Tạo giá trị tuyệt đối của các toán hạng nếu cần
//                 if (sign_a) a_d = -operand_a_i;
//                 if (sign_b) b_d = -operand_b_i;


//                 product_d = 64'b0;
//                 count_d   = 6'b0;
//                 state_d   = CALC;
//             end
//         end

//         CALC: begin
//             if (count_q < 32) begin
//                 // Nếu b_q[0] == 1, cộng a_q vào product
//                 if (b_q[0]) begin
//                     product_d = product_q + {32'b0, a_q};
//                 end
//                 a_d      = a_q << 1;  // Dịch trái a_q
//                 b_d      = b_q >> 1;  // Dịch phải b_q
//                 count_d  = count_q + 1;
//             end else begin
//                 state_d = COMPLETE;  // Chuyển trạng thái khi đủ 32 chu kỳ
//             end
//         end

//         COMPLETE: begin
//             // Xử lý dấu nếu cần
//             if ((sign_a ^ sign_b)) begin
//                 product_d = -product_q;
//             end else begin
//                 product_d = product_q;
//             end

//             // Chọn kết quả dựa trên loại lệnh
//             case (func_i)
//                 2'b00: result_o = product_d[31:0];   // MUL: phần thấp của sản phẩm
//                 2'b01: result_o = product_d[63:32];  // MULH: phần cao của sản phẩm có dấu
//                 2'b10: result_o = product_d[63:32];  // MULHU: phần cao của sản phẩm không dấu
//                 2'b11: result_o = product_d[63:32];  // MULHSU: phần cao của sản phẩm với a có dấu, b không dấu
//             endcase
//             valid_o = 1'b1;
//             state_d = IDLE;
//         end
//     endcase
// end

// endmodule


// 

// module multiplier (
//     input           clk_i,
//     input           rst_ni,
//     input           start_i,        // Start signal
//     input  [31:0]   operand_a_i,     // Operand A
//     input  [31:0]   operand_b_i,     // Operand B
//     input  [1:0]    func_i,          // Function select (00: MUL, 01: MULH, 10: MULHU, 11: MULHSU)
//     output reg [31:0] result_o,      // Output result
//     output reg       valid_o         // Output valid signal
// );

// localparam IDLE        = 2'b00;
// localparam CALC_STAGE1 = 2'b01;
// localparam CALC_STAGE2 = 2'b10;
// localparam COMPLETE    = 2'b11;

// reg [1:0] state_q, state_d;
// reg [63:0] product_q, product_d;
// reg [15:0] a_low, a_high, b_low, b_high;
// reg signed [31:0] partial_product1, partial_product2, partial_product3, partial_product4;
// reg sign_a, sign_b;
// reg [1:0]  cycle_count_q, cycle_count_d;

// always @(posedge clk_i or negedge rst_ni) begin
//     if (!rst_ni) begin
//         state_q      <= IDLE;
//         product_q    <= 64'b0;
//         cycle_count_q <= 2'b0;
//     end else begin
//         state_q      <= state_d;
//         product_q    <= product_d;
//         cycle_count_q <= cycle_count_d;
//     end
// end

// always @(*) begin
//     state_d       = state_q;
//     product_d     = product_q;
//     cycle_count_d = cycle_count_q;
//     valid_o       = 1'b0;
//     result_o      = 32'b0;

//     case (state_q)
//         IDLE: begin
//             if (start_i) begin
//                 // Split operands into high and low 16-bit parts
//                 a_low = operand_a_i[15:0];
//                 a_high = operand_a_i[31:16];
//                 b_low = operand_b_i[15:0];
//                 b_high = operand_b_i[31:16];

//                 // Handle sign bits for different functions
//                 sign_a = (func_i != 2'b10) && operand_a_i[31];  // Signed if not MULHU
//                 sign_b = (func_i == 2'b00 || func_i == 2'b01) && operand_b_i[31];  // Signed if MUL or MULH

//                 product_d = 64'b0;
//                 cycle_count_d = 2'b0;
//                 state_d = CALC_STAGE1;
//             end
//         end

//         CALC_STAGE1: begin
//             // Calculate partial products
//             partial_product1 = $signed({1'b0, a_low}) * $signed({1'b0, b_low});  // al * bl
//             partial_product2 = $signed({1'b0, a_low}) * $signed({sign_b, b_high});  // al * bh
//             partial_product3 = $signed({sign_a, a_high}) * $signed({1'b0, b_low});  // ah * bl
//             partial_product4 = $signed({sign_a, a_high}) * $signed({sign_b, b_high});  // ah * bh

//             product_d = {32'b0, partial_product1};  // Initial product is just al * bl
//             state_d = CALC_STAGE2;
//             cycle_count_d = cycle_count_q + 1;
//         end

//         CALC_STAGE2: begin
//             // Accumulate partial products
//             if (cycle_count_q == 1) begin
//                 product_d = product_q + {partial_product2, 16'b0};  // Add al * bh << 16
//                 product_d = product_d + {partial_product3, 16'b0};  // Add ah * bl << 16
//                 product_d = product_d + {partial_product4, 32'b0};  // Add ah * bh << 32

//                 state_d = COMPLETE;
//                 cycle_count_d = cycle_count_q + 1;
//             end
//         end

//         COMPLETE: begin
//             // Choose the correct result based on func_i
//             case (func_i)
//                 2'b00: result_o = product_d[31:0];   // MUL: lower 32 bits of product
//                 2'b01: result_o = product_d[63:32];  // MULH: upper 32 bits of product (signed)
//                 2'b10: result_o = product_d[63:32];  // MULHU: upper 32 bits of unsigned product
//                 2'b11: result_o = product_d[63:32];  // MULHSU: upper 32 bits of signed/unsigned product
//             endcase

//             valid_o = 1'b1;
//             state_d = IDLE;
//         end
//     endcase
// end

// endmodule







module tb_fast_multi_cycle_multiplier;

    // Inputs
    reg clk;
    reg rst_ni;
    reg start_i;
    reg [31:0] operand_a_i;
    reg [31:0] operand_b_i;
    reg [1:0] func_i;

    // Outputs
    wire [31:0] result_o;
    wire valid_o;

    // Instantiate the Unit Under Test (UUT)
    multiplier uut (
        .clk_i(clk),
        .rst_ni(rst_ni),
        .start_i(start_i),
        .operand_a_i(operand_a_i),
        .operand_b_i(operand_b_i),
        .func_i(func_i),
        .result_o(result_o),
        .valid_o(valid_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period (100 MHz)
    end

    // // Test sequence
    // initial begin
    //     // Initialize Inputs
    //     rst_ni = 0;
    //     start_i = 0;
    //     operand_a_i = 0;
    //     operand_b_i = 0;
    //     func_i = 2'b00; // MUL operation

    //     // Apply reset
    //     #20;
    //     rst_ni = 1;

    //     // Test case 1: Simple multiplication
    //     #10;
    //     operand_a_i = 32'h0000000F; // 15
    //     operand_b_i = 32'h00000003; // 3
    //     func_i = 2'b00; // MUL
    //     start_i = 1;
    //     #10;
    //     start_i = 0;

    //     // Wait for the result to be valid
    //     wait(valid_o);
    //     #10;
    //     if (result_o != 32'd45) $display("Test case 1 failed: expected 45, got %d", result_o);
    //     else $display("Test case 1 passed");

    //     // Test case 2: Multiplication with negative numbers (MUL)
    //     #10;
    //     operand_a_i = 32'hFFFFFFF1; // -15
    //     operand_b_i = 32'h00000003; // 3
    //     func_i = 2'b00; // MUL
    //     start_i = 1;
    //     #10;
    //     start_i = 0;

    //     // Wait for the result to be valid
    //     wait(valid_o);
    //     #10;
    //     if (result_o != 32'hFFFFFFD3) $display("Test case 2 failed: expected -45, got %d", result_o);
    //     else $display("Test case 2 passed");

    //     // Test case 3: MULH operation
    //     #10;
    //     operand_a_i = 32'h0000FFFF; // 65535
    //     operand_b_i = 32'h0000FFFF; // 65535
    //     func_i = 2'b01; // MULH
    //     start_i = 1;
    //     #10;
    //     start_i = 0;

    //     // Wait for the result to be valid
    //     wait(valid_o);
    //     #10;
    //     if (result_o != 32'h0000FFFE) $display("Test case 3 failed: expected 0x0000FFFE, got %h", result_o);
    //     else $display("Test case 3 passed");

    //     // Test case 4: MULHU operation
    //     #10;
    //     operand_a_i = 32'hFFFFFFFF; // -1
    //     operand_b_i = 32'h00000002; // 2
    //     func_i = 2'b10; // MULHU
    //     start_i = 1;
    //     #10;
    //     start_i = 0;

    //     // Wait for the result to be valid
    //     wait(valid_o);
    //     #10;
    //     if (result_o != 32'h00000001) $display("Test case 4 failed: expected 1, got %d", result_o);
    //     else $display("Test case 4 passed");

    //     // Test case 5: MULHSU operation
    //     #10;
    //     operand_a_i = 32'h80000000; // -2147483648
    //     operand_b_i = 32'h00000002; // 2
    //     func_i = 2'b11; // MULHSU
    //     start_i = 1;
    //     #10;
    //     start_i = 0;

    //     // Wait for the result to be valid
    //     wait(valid_o);
    //     #10;
    //     if (result_o != 32'hFFFFFFFF) $display("Test case 5 failed: expected 0xFFFFFFFF, got %h", result_o);
    //     else $display("Test case 5 passed");

    //     // Finish the test
    //     #10000
    //     $stop;
    // end

reg [31:0] tb_results[0:4];

initial begin
    // Initialize Inputs
    rst_ni = 0;
    start_i = 0;
    operand_a_i = 0;
    operand_b_i = 0;
    func_i = 2'b00; // MUL operation

    // Apply reset
    #20;
    rst_ni = 1;

    // Test case 1: Simple multiplication
    #10;
    // operand_a_i = 32'hFFFFFFF1; // -15
    // operand_b_i = 32'h00000005; // 5
    operand_a_i = -7; // -15
    operand_b_i = -8; // 5    
    func_i = 2'b00; // MUL
    start_i = 1;
    #10;
    start_i = 0;

    // Wait for the result to be valid
    wait(valid_o);
    #10;
    tb_results[0] = result_o;

    // Test case 2: MULH operation
    #10;
    func_i = 2'b01; // MULH
    start_i = 1;
    #10;
    start_i = 0;

    // Wait for the result to be valid
    wait(valid_o);
    #10;
    tb_results[1] = result_o;

    // Test case 3: MULHU operation
    #100;
    func_i = 2'b10; // MULHU
    start_i = 1;
    #10;
    start_i = 0;

    // Wait for the result to be valid
    wait(valid_o);
    #10;
    tb_results[2] = result_o;

    // Test case 4: MULHSU operation
    #10;
    func_i = 2'b11; // MULHSU
    start_i = 1;
    #10;
    start_i = 0;

    // Wait for the result to be valid
    wait(valid_o);
    #10;
    tb_results[3] = result_o;

    // Final test case result display
    #10000
    $display("Testbench results:");
    $display("tb_results[0]: %h", tb_results[0]);
    $display("tb_results[1]: %h", tb_results[1]);
    $display("tb_results[2]: %h", tb_results[2]);
    $display("tb_results[3]: %h", tb_results[3]);
    $stop;
end

endmodule