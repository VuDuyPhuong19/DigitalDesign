module time_24h(
	input clk_1h,
	input rst_24h,
	input stop,
    input adjust_clk,
	output reg [6:0]one_hour,
	output reg [6:0]ten_hour,
	output reg next_day
);
localparam MAX_S=9;
localparam MAX_T=5;
localparam MAX_K=2;
localparam MAX_D =3;
reg [6:0] counter;
wire intermediate_clk;
// Chọn clock dựa trên trạng thái của stop
assign intermediate_clk = stop ? adjust_clk : clk_1h;
always @(posedge intermediate_clk or negedge rst_24h) begin
	if(~rst_24h) begin
		one_hour<=0;
		ten_hour<=0;
		next_day<=0;
	end
	else begin
		if(ten_hour==MAX_K) begin
			if(one_hour==MAX_D) begin
			   next_day<=1;
			   one_hour<=0;
			   ten_hour<=0;
			 end
			 else begin  
			    one_hour<=one_hour+1;
				 next_day<=0;
			  end
		end
		else begin
		   if(one_hour==MAX_S) begin 
		     ten_hour<=ten_hour+1;
		     one_hour<=0;
			  next_day<=0;
		   end
		   else begin
		     one_hour=one_hour+1;
			  next_day<=0;
		   end
		 end
  end
end
endmodule