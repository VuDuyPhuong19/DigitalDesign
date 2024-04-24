
module multiply_fixed_point(
    input wire signed [15:0] integer_input,    // Sá»‘ nguyÃªn 16-bit
    input wire signed [31:0] real_input,       // Sá»‘ thá»±c 32-bit, 1 bit dáº¥u, 3 bit nguyÃªn, 28 bit tháº­p phÃ¢n
    output wire signed [47:0] result   // Äáº§u ra sá»‘ nguyÃªn 16-bit
);

// Thá»±c hiá»‡n phÃ©p nhÃ¢n, káº¿t quáº£ táº¡m thá»i lÃ  48-bit Ä‘á»ƒ Ä‘áº£m báº£o khÃ´ng máº¥t mÃ¡t thÃ´ng tin
wire signed [47:0] multiply_result = $signed(integer_input) * real_input;

// Scale vÃ  lÃ m trÃ²n káº¿t quáº£ Ä‘á»ƒ phÃ¹ há»£p vá»›i Ä‘áº§u ra 16-bit.
// LÆ°u Ã½: Viá»‡c dá»‹ch 28 bit giÃºp loáº¡i bá» pháº§n tháº­p phÃ¢n, nhÆ°ng cáº§n xem xÃ©t cáº©n tháº­n cÃ¡ch lÃ m trÃ²n
//wire signed [15:0] rounded_result = multiply_result[47:28] + {{15{multiply_result[27]}}, multiply_result[27]};

assign result = multiply_result;

endmodule

`timescale 1ns / 1ps

module testbench;

    // Inputs
    reg signed [15:0] integer_input;
    reg signed [31:0] real_input;

    // Output
    wire signed [15:0] result;

    // Instantiate the Device Under Test (DUT)
    multiply_fixed_point dut (
        .integer_input(integer_input), 
        .real_input(real_input), 
        .result(result)
    );

    // Initialize all inputs
    initial begin
        // Initialize Inputs
        integer_input = 0;
        real_input = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // Input test values
        integer_input = 16'd17527;             // Positive integer
        real_input = 32'h007537fb;          // Positive real (1.0 in fixed-point)
        #10;                                   // Wait for the result
        
        integer_input = -16'sd1000;            // Negative integer
        real_input = -32'sd2000000000;         // Negative real (-2.0 in fixed-point)
        #10;

        integer_input = 16'sd500;             // Smaller positive integer
        real_input = 32'sd500000000;          // Smaller real (0.5 in fixed-point)
        #10;

        integer_input = -16'sd500;            // Negative integer
        real_input = 32'sd1073741824;         // Positive real approx. (0.25 in fixed-point)
        #10;
        
        integer_input = 16'sd32767;           // Max positive integer
        real_input = 32'sd1073741824;         // Real input (0.25 in fixed-point)
        #10;
        
        integer_input = -16'sd32768;          // Max negative integer
        real_input = -32'sd2147483648;        // Real input (-2.0 in fixed-point)
        #10;

        // Test rounding
        integer_input = 16'sd123;             // Test rounding
        real_input = 32'sd234881024;          // Close to 0.055 in fixed-point
        #10;

        // Complete the test
        $finish;
    end
    
    // Monitor changes and display them
    initial begin
        $monitor("At time %t, input = %d, real_input = %d, result = %d",
                 $time, integer_input, real_input, result);
    end

endmodule

