module MonthCounter(
    input clk,    // Clock input (assumed to be 1Hz for simplicity)
    input reset,  // Reset input, to reset the counter to 0
    output reg [3:0] month ,  // 6-bit output for the seconds value
	 output reg one_year =0// Output that indicates a minute has passed
);


always @(posedge clk or negedge reset) begin
    if (~reset) begin
        // Reset the counter to 0 if reset signal is high
        month <= 3;
		  one_year <= 0;
    end else begin
        // Increment the counter each second, reset to 0 after reaching 59
        if (month == 12) begin
            month <= 1;
				one_year <=1;
        end else begin
            month <= month + 1;
				one_year <=0;
        end
    end
end

endmodule
