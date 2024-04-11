module SecondCounter(
    input clk,    // Clock input (assumed to be 1Hz for simplicity)
    input reset,  // Reset input, to reset the counter to 0
    output reg [5:0] second ,  // 6-bit output for the seconds value
	 output reg one_min =0// Output that indicates a minute has passed
);


always @(posedge clk or negedge reset) begin
    if (~reset) begin
        // Reset the counter to 0 if reset signal is high
        second <= 0;
		  one_min <= 0;
    end else begin
        // Increment the counter each second, reset to 0 after reaching 59
        if (second == 59) begin
            second <= 0;
				one_min <=1;
        end else begin
            second <= second + 1;
				one_min <=0;
        end
    end
end

endmodule
