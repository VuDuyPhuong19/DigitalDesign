module DayCounter(
    input clk,    // Clock input (assumed to be 1Hz for simplicity)
    input reset,  // Reset input, to reset the counter and month to initial state
	 input leap_year,
    output reg [5:0] day = 1,  // 6-bit output for the day value, start from day 1
    output reg one_month = 0  // Output that indicates a month has passed
);

// Define the number of days in each month
// Note: February is simplified to 28 days for this example. Leap years are not considered.
localparam JAN = 1, FEB = 2, MAR = 3, APR = 4, MAY = 5, JUN = 6,
           JUL = 7, AUG = 8, SEP = 9, OCT = 10, NOV = 11, DEC = 12;
 reg [4:0] current_month = MAR; // 5-bit output for the current month, start from January

always @(posedge clk or negedge reset) begin
    if (~reset) begin
        day <= 26;
        current_month <= MAR;
        one_month <= 0;
    end else begin
        one_month <= 0; // Default to 0 at the beginning of the clock cycle
        // Check the current month to determine the number of days
        case (current_month)
            FEB: begin
                if (day == (28+ leap_year)) begin
                    day <= 1;
                    current_month <= current_month + 1;
                    one_month <= 1;
                end else begin
                    day <= day + 1;
                end
            end
            APR, JUN, SEP, NOV: begin
                if (day == 30) begin
                    day <= 1;
                    current_month <= (current_month == NOV) ? JAN : current_month + 1;
                    one_month <= 1;
                end else begin
                    day <= day + 1;
                end
            end
            default: begin
                if (day == 31) begin
                    day <= 1;
                    current_month <= (current_month == DEC) ? JAN : current_month + 1;
                    one_month <= 1;
                end else begin
                    day <= day + 1;
                end
            end
        endcase
    end
end

endmodule
