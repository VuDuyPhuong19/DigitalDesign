module YearCounter(
    input clk,    // Clock input (assumed to be 1Hz for simplicity)
    input reset,  // Reset input, to reset the counter to 0
    output reg [6:0] year ,  // 6-bit output for the seconds value
	 output reg leap_year =0// Output that indicates a minute has passed
);


always @(posedge clk or negedge reset) begin
    if (~reset) begin
        // Reset the counter to 0 if reset signal is high
        year <= 24;
		  leap_year <= 0;
    end else begin
        // Increment the counter each second, reset to 0 after reaching 59
        if (year %4 == 0) begin
            leap_year<=1;
        end else begin
            year <= year + 1;
				leap_year <=0;
        end
    end
end

endmodule
