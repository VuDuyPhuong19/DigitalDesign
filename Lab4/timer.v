// Datapath
module timer #(
	parameter TIMEOUT_BIT = 4,
	parameter t_bit = 2
)(        
	input clk,           
	input start,
	input clk_1s_enable,
	output reg [TIMEOUT_BIT-1:0] Timeout,
	output reg [t_bit-1:0] timeout
);

parameter TIMEOUT_MAX = 9;
parameter tIMEOUT_MAX = 3;

initial begin
	Timeout = TIMEOUT_MAX;
	timeout = tIMEOUT_MAX;
end

always @ (posedge clk) begin
	// if (clk_1s_enable) begin
		if (start) begin
			Timeout <= TIMEOUT_MAX;
			timeout <= tIMEOUT_MAX;
		end
		else begin
            if (Timeout != 0) begin
                Timeout <= Timeout - 1;
            end else if (timeout != 0) begin
                timeout <= timeout - 1;
            end
		end
	// end
end

endmodule

module timer_tb();
reg clk, start, clk_1s_enable;
parameter TIMEOUT_BIT = 4;
parameter t_bit = 2;
wire [TIMEOUT_BIT-1:0] Timeout;
wire [t_bit-1:0] timeout;

timer uut(.clk(clk),
		  .start(start),
		  .clk_1s_enable(clk_1s_enable),
		  .Timeout(Timeout),
		  .timeout(timeout)
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	clk_1s_enable = 1;
	#10 start = 1;
	#10 start = 0;
	#100 start = 1;
	#10 start = 0;
	#1000 $finish;
end

endmodule