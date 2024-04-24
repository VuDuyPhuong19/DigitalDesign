module countryroad_controller(
    input clk,
    input reset,
    input car ,
    input time_out,
	input T_out,
    input enable_r,
    output reg enable_h,
    output reg start_r,
    output reg [2:0]light_r
);
reg [2:0] CurrentState,NextState;
wire car_signal_delay;
reg car_prev;
parameter [2:0] green_r = 3'b100, yellow_r = 3'b010, red_r = 3'b001;
Debounce DB1(
    .clk(clk),
    .reset(reset),
    .D(car),
    .Qout(car_signal_delay)
);
always @(posedge clk  or negedge reset)begin
    if(!reset)
        CurrentState<=red_r;
    else
        CurrentState <=NextState;
        car_prev<=car_signal_delay;
end

 // Gán đầu ra light_h theo trạng thái hiện tại
always @(CurrentState) begin
        light_r = CurrentState;
 end

always  @(NextState, CurrentState,enable_r,T_out,time_out, car) begin

    case  (CurrentState)
    green_r :
        if (T_out==1)begin
        NextState = yellow_r;
        start_r=1;
        end else begin
            NextState=CurrentState;
            enable_h=0;
        end
    yellow_r :
        if( time_out==1 )begin
            NextState=red_r;
            enable_h=1;
        end  else begin
             NextState=CurrentState;
        end
    red_r   :
        if( enable_r==1 )begin
            NextState=green_r;
            start_r=1;
        end else begin
            if (car ==1) begin
                start_r=1;
            end else begin
            NextState=CurrentState;
            enable_h=0;
            start_r=0;
            end
        end
    endcase
end
endmodule
