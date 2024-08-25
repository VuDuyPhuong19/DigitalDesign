// // one_cycle_divider

// module divider (
//     input           clk_i,
//     input           rst_ni,
//     input           start_i,
//     input  [31:0]   operand_a_i,
//     input  [31:0]   operand_b_i,
//     input  [1:0]    func_i,          // Function select (00: DIV, 01: DIVU, 10: REM, 11: REMU)
//     output reg [31:0] result_o,      // Output result
//     output reg div_done_o         // Output valid signal
// );

// reg [31:0] quotient;
// reg [31:0] remainder;
// reg [31:0] abs_a, abs_b;
// reg sign_a, sign_b;

// // Combinational logic for single-cycle division
// always @(*) begin
//     div_done_o = 1'b0;
//     result_o = 32'b0;
//     quotient = 32'b0;
//     remainder = 32'b0;
    
//     sign_a = (func_i == 2'b00 || func_i == 2'b10) && operand_a_i[31];
//     sign_b = (func_i == 2'b00 || func_i == 2'b10) && operand_b_i[31];

//     // Absolute values
//     abs_a = sign_a ? -operand_a_i : operand_a_i;
//     abs_b = sign_b ? -operand_b_i : operand_b_i;

//     // Perform division and calculate remainder
//     if (operand_b_i != 0) begin
//         quotient = abs_a / abs_b;
//         remainder = abs_a % abs_b;
//     end else begin
//         quotient = 32'hFFFFFFFF; // Division by zero, set quotient to -1
//         remainder = abs_a; // Division by zero, remainder is the dividend
//     end

//     // Adjust signs based on function
//     if (func_i == 2'b00 || func_i == 2'b10) begin
//         if (sign_a ^ sign_b) begin
//             quotient = -quotient;
//         end
//         if (sign_a && func_i == 2'b10) begin
//             remainder = -remainder;
//         end
//     end

//     // Select the appropriate output
//     case (func_i)
//         2'b00: result_o = quotient;   // DIV
//         2'b01: result_o = quotient;   // DIVU
//         2'b10: result_o = remainder;  // REM
//         2'b11: result_o = remainder;  // REMU
//     endcase

//     div_done_o = start_i;
// end

// endmodule


// 32_cycles_divider

// module divider (
//     input           clk_i,
//     input           rst_ni,
//     input           start_i,
//     input  [31:0]   operand_a_i,
//     input  [31:0]   operand_b_i,
//     input  [1:0]    func_i,          // Function select (00: DIV, 01: DIVU, 10: REM, 11: REMU)
//     output reg [31:0] result_o,      // Output result
//     output reg       div_done_o         // Output valid signal
// );

// localparam IDLE        = 3'b000;
// localparam EXECUTE     = 3'b001;
// localparam COMPLETE    = 3'b010;

// reg [2:0] state_q, state_d;
// reg [31:0] quotient_q, quotient_d;
// reg [31:0] remainder_q, remainder_d;
// reg [31:0] dividend_q, dividend_d;
// reg [31:0] divisor_q, divisor_d;
// reg [5:0]  count_q, count_d;
// reg        sign_a, sign_b;

// always @(posedge clk_i or negedge rst_ni) begin
//     if (!rst_ni) begin
//         state_q <= IDLE;
//         quotient_q <= 32'b0;
//         remainder_q <= 32'b0;
//         dividend_q <= 32'b0;
//         divisor_q <= 32'b0;
//         count_q <= 6'b0;
//     end else begin
//         state_q <= state_d;
//         quotient_q <= quotient_d;
//         remainder_q <= remainder_d;
//         dividend_q <= dividend_d;
//         divisor_q <= divisor_d;
//         count_q <= count_d;
//     end
// end

// always @(*) begin
//     state_d = state_q;
//     quotient_d = quotient_q;
//     remainder_d = remainder_q;
//     dividend_d = dividend_q;
//     divisor_d = divisor_q;
//     count_d = count_q;
//     div_done_o = 1'b0;
//     result_o = 32'b0;

//     case (state_q)
//         IDLE: begin
//             if (start_i) begin
//                 sign_a = (func_i == 2'b00 || func_i == 2'b10) && operand_a_i[31];
//                 sign_b = (func_i == 2'b00 || func_i == 2'b10) && operand_b_i[31];

//                 // Absolute value of dividend and divisor
//                 dividend_d = sign_a ? -operand_a_i : operand_a_i;
//                 divisor_d = sign_b ? -operand_b_i : operand_b_i;

//                 quotient_d = 32'b0;
//                 remainder_d = 32'b0;
//                 count_d = 6'd32; // 32-bit division

//                 state_d = EXECUTE;
//             end
//         end

//         EXECUTE: begin
//             if (count_q > 0) begin
//                 // Shift left remainder and bring down next dividend bit
//                 remainder_d = {remainder_q[30:0], dividend_q[31]};
//                 dividend_d = {dividend_q[30:0], 1'b0};

//                 // Subtract divisor from remainder and update quotient
//                 if (remainder_d >= divisor_q) begin
//                     remainder_d = remainder_d - divisor_q;
//                     quotient_d = {quotient_q[30:0], 1'b1};
//                 end else begin
//                     quotient_d = {quotient_q[30:0], 1'b0};
//                 end

//                 count_d = count_q - 1;
//             end else begin
//                 state_d = COMPLETE;
//             end
//         end

//         COMPLETE: begin
//             // Adjust sign of quotient and remainder if needed
//             if (func_i == 2'b00 || func_i == 2'b10) begin
//                 if (sign_a ^ sign_b) begin
//                     quotient_d = -quotient_q;  // Adjust quotient sign
//                 end
//                 if (sign_a) begin
//                     remainder_d = -remainder_q; // Adjust remainder sign if dividend was negative
//                 end
//             end

//             // Output result based on function
//             case (func_i)
//                 2'b00: result_o = quotient_d;   // DIV
//                 2'b01: result_o = quotient_d;   // DIVU
//                 2'b10: result_o = remainder_d;  // REM
//                 2'b11: result_o = remainder_d;  // REMU
//             endcase
//             div_done_o = 1'b1;
//             state_d = IDLE;
//         end
//     endcase
// end

// endmodule

// 3_cycles_divider

module divider #(
    parameter OP_WIDTH = 32,
    parameter MULT_DIV_WIDTH = 32
)(
    input           clk_i,
    input           rst_ni,
    input           start_i,
    input  [OP_WIDTH-1:0]   operand_a_i,
    input  [OP_WIDTH-1:0]   operand_b_i,
    input  [1:0]    func_i,          // Function select (00: DIV, 01: DIVU, 10: REM, 11: REMU)
    output reg [MULT_DIV_WIDTH-1:0] result_o,      // Output result
    output reg       div_done_o         // Output valid signal
);

// State Definitions
localparam IDLE        = 2'b00;
localparam EXECUTE     = 2'b01;
localparam COMPLETE    = 2'b10;

// Internal signals and registers
reg [1:0]  state_q, state_d;
reg [31:0] quotient;
reg [31:0] remainder;
reg [31:0] abs_a, abs_b;
reg sign_a, sign_b;

// State register update
always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        state_q <= IDLE;
    end else begin
        state_q <= state_d;
    end
end

// Combinational logic for state transitions and division logic
always @(*) begin
    state_d = state_q;  // Default: stay in the current state
    div_done_o = 1'b0;     // Default: not valid
    result_o = 32'b0;   // Default: zero result

    case (state_q)
        IDLE: begin
            if (start_i) begin
                // Determine the sign of the inputs
                sign_a = (func_i == 2'b00 || func_i == 2'b10) && operand_a_i[31];
                sign_b = (func_i == 2'b00 || func_i == 2'b10) && operand_b_i[31];

                // Compute absolute values
                abs_a = sign_a ? -operand_a_i : operand_a_i;
                abs_b = sign_b ? -operand_b_i : operand_b_i;

                state_d = EXECUTE;
            end
        end

        EXECUTE: begin
            // Perform division and remainder calculation
            if (operand_b_i != 0) begin
                quotient = abs_a / abs_b;
                remainder = abs_a % abs_b;
            end else begin
                quotient = 32'hFFFFFFFF; // Division by zero, set quotient to -1
                remainder = abs_a;       // Division by zero, remainder is the dividend
            end

            // Adjust signs based on the operation
            if (func_i == 2'b00 || func_i == 2'b10) begin
                if (sign_a ^ sign_b) begin
                    quotient = -quotient;
                end
                if (sign_a && func_i == 2'b10) begin
                    remainder = -remainder;
                end
            end

            state_d = COMPLETE;
        end

        COMPLETE: begin
            // Select the appropriate output
            case (func_i)
                2'b00: result_o = quotient;   // DIV
                2'b01: result_o = quotient;   // DIVU
                2'b10: result_o = remainder;  // REM
                2'b11: result_o = remainder;  // REMU
            endcase

            div_done_o = 1'b1;    // Indicate the result is valid
            state_d = IDLE;    // Return to the IDLE state
        end
    endcase
end

endmodule






module tb_divider;

    // Inputs
    reg clk_i;
    reg rst_ni;
    reg start_i;
    reg [31:0] operand_a_i;
    reg [31:0] operand_b_i;
    reg [1:0] func_i;

    // Outputs
    wire [31:0] result_o;
    wire div_done_o;

    // Instantiate the Unit Under Test (UUT)
    divider uut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .start_i(start_i),
        .operand_a_i(operand_a_i),
        .operand_b_i(operand_b_i),
        .func_i(func_i),
        .result_o(result_o),
        .div_done_o(div_done_o)
    );

    // Clock generation
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst_ni = 0;
        start_i = 0;
        operand_a_i = 0;
        operand_b_i = 0;
        func_i = 2'b00;

        // Apply reset
        #20;
        rst_ni = 1;

        // Test case 1: DIV operation (signed division)
        #10;
        operand_a_i = 15; // -15
        operand_b_i = 7; // 5
        func_i = 2'b00; // DIV
        start_i = 1;
        #10;
        start_i = 0;

        // Wait for the result to be valid
        wait(div_done_o);
        #10;
        $display("Test case 1 failed: expected -3, got %h", result_o);
 //       else $display("Test case 1 passed");

        // Test case 2: DIVU operation (unsigned division)
        #10;
        operand_a_i = 15; // 4294967281 (unsigned representation of -15)
        operand_b_i = 7; // 5
        func_i = 2'b01; // DIVU
        start_i = 1;
        #10;
        start_i = 0;

        // Wait for the result to be valid
        wait(div_done_o);
        #10;
        if (result_o !== 858993456) $display("Test case 2 failed: expected 858993456, got %h", result_o);
        else $display("Test case 2 passed");

        // Test case 3: REM operation (signed remainder)
        #10;
        operand_a_i = 15; // -15
        operand_b_i = 7; // 5
        func_i = 2'b10; // REM
        start_i = 1;
        #10;
        start_i = 0;

        // Wait for the result to be valid
        wait(div_done_o);
        #10;
        if (result_o !== 0) $display("Test case 3 failed: expected -1, got %h", result_o);
        else $display("Test case 3 passed");

        // Test case 4: REMU operation (unsigned remainder)
        #10;
        operand_a_i = 15; // 4294967281 (unsigned representation of -15)
        operand_b_i = 7; // 5
        func_i = 2'b11; // REMU
        start_i = 1;
        #10;
        start_i = 0;

        // Wait for the result to be valid
        wait(div_done_o);
        #10;
        if (result_o !== 1) $display("Test case 4 failed: expected 1, got %h", result_o);
        else $display("Test case 4 passed");

        // Additional test cases can be added here...

        // Finish the simulation
        $stop;
    end

endmodule

