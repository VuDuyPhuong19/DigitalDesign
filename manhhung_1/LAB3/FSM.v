module FSM(
	input clk,
	input rst,
	input change_mode,
	output wire [6:0] led_1,
	output wire [6:0] led_2,
	output wire [6:0] led_3,
	output wire [6:0] led_4,
	output wire [6:0] led_5,
	output wire [6:0] led_6,
	output wire [6:0] led_7,
	output wire [6:0] led_8
);
localparam time_display=0;
localparam date_display=1;
reg temp=0;
always@(posedge clk or negedge rst) begin
	if(~rst) begin
		temp=1;
	end
	else begin
		
	end
end
endmodule
	