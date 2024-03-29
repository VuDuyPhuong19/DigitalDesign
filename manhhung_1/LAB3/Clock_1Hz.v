module Clock_1Hz(	
	input wire sys_clk,
	input wire rst_n,
	output reg clk_1hz=0
);
localparam COUNT_1S=25000000-1;
reg [26:0] counter=0;
always @(posedge sys_clk or negedge rst_n) begin
	if(~rst_n) begin
		counter<=0;
		clk_1hz<=0;
	end
	else begin 
			if(counter==COUNT_1S) begin
				clk_1hz<=~clk_1hz;
				counter=0;
			end
			else begin
				counter=counter+1;
			end
		end
	end
endmodule
	
