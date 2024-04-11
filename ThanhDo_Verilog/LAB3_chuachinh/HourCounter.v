module HourCounter(
    input clk,    // Clock input (assumed to be 1Hz for simplicity)
    input reset,  // Reset input, to reset the counter to 0
    output reg [4:0] hour ,  // 6-bit output for the seconds value
	 output reg one_day =0// Output that indicates a minute has passed
);


always @(posedge clk or negedge reset) begin
    if (~reset) begin
        // Reset the counter to 0 if reset signal is high
        hour <= 10;
		  one_day <= 0;
    end else begin
        // Increment the counter each second, reset to 0 after reaching 59
        if (hour == 23) begin
            hour <= 0;
				one_day <=1;
        end else begin
            hour <= hour + 1;
				one_day <=0;
        end
    end
end

endmodule
