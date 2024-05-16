module timer(
    input clk,          // Clock signal
    input clk_1Hz,      // 1Hz clock signal for counting
    input reset,        // Reset signal
    input start,        // Start counting signal
    output reg T_out,   // Output signal when time is up
    output reg time_out,// Timeout flag
    output reg [5:0] count // 6-bit count
);
    reg [5:0] internal_count;
    reg clk_1Hz_prev; // Previous state of clk_1Hz to detect edge

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            internal_count <= 30;
            //count <= 40;
            T_out <= 0;
            //time_out <= 1;
            clk_1Hz_prev <= 0;
        end else 
         begin
            // Update the previous state of clk_1Hz
            clk_1Hz_prev <= clk_1Hz;

            // Check for rising edge of clk_1Hz
            if (start && clk_1Hz && !clk_1Hz_prev) begin
                if (internal_count > 0) begin
                    internal_count <= internal_count - 1;
                    time_out<=0;
                    T_out<=0;
                end

                if (internal_count==30) time_out <= 1;
                if (internal_count == 0 ) begin
                    T_out <= 1;
                    internal_count <= 40; // Reset the counter
                end 
            end

            // Update external count always when start is high
            if (start) count <= internal_count;
            else begin 
                count<=0; // khong dem
                internal_count<=0;

            end

         end
    end
endmodule
