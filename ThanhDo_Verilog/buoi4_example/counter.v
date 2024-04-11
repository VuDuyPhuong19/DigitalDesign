module counter # (
parameter n=8 )
(
	input clk, rst_n,
	input updown,
	output reg[n-1:0] cnt

);


always @(posedge clk or negedge rst_n)
begin
	if(~rst_n) cnt<=0;
	else begin
	if(updown==1) cnt<= cnt+1;
	else cnt<=cnt-1;
	end	
	
end



endmodule



