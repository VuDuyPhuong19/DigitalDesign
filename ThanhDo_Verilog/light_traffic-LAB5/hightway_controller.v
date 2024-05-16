module hightway_controller
(
	input clk,
	input reset,
	input car,
	input time_out,
	input T_out,
	input enable_h,
	output reg enable_r,
	output reg start_h,
	output reg [2:0] light_h
	
);
reg [2:0] CurrentState, NextState;
parameter [2:0] green_h = 3'b100, yellow_h = 3'b010, red_h = 3'b001;

always  @(posedge clk or negedge reset) begin
	if(!reset)
	CurrentState<=green_h;
	else 
	CurrentState=NextState;

end

 // Gán đầu ra light_h theo trạng thái hiện tại
always @(CurrentState) begin
        light_h = CurrentState;
 end

always @(NextState, CurrentState,enable_h,T_out,time_out, car) begin
	case (CurrentState)
		green_h : if(car==1 && T_out==1 ) //
		begin
			NextState=yellow_h;
			start_h=1;
		end else begin
			NextState=CurrentState;
			start_h=0;
			enable_r=0;
		end
		yellow_h : if(time_out==1) // da chay het den vang
		begin
			NextState=red_h;
			enable_r=1;
			start_h=0;
		end else begin
			NextState=CurrentState;
			enable_r=0;
			
			end
			
		red_h : if(enable_h)
		begin
			NextState=green_h;
			start_h= 1;
		end  else begin
			NextState=CurrentState;
			enable_r=0;
			start_h= 0;
        end
	endcase
	
end



endmodule