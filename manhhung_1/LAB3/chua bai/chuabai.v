module snt_s
(
    input clk_50Mhz,
    input rst_n,
    input set_s,
    output pulse_1s,
    output reg [6:0] cnt_s;
    output reg pulse_1mi
);
always @(posedge clk_50Mhz negedge rst_n) begin 
    if(~rst_n) begin   
        cnt_s<=0;
        pulse_1mi<=1;
    end
    else begin
        if(cnt_s==60)
            begin 
                cnt_s<=0;
                pulse_1mi<=1;
            end
            else
                if(set_s) begin cnt_s<=cnt_s+1; pulse_1mi<=0; end
            else 
                if(pulse_1s) begin
                    cnt_s<=cnt_s+1; pulse_1mi<=0; end
                else begin
                    cnt_s <= cnt_s; pulse_1mi<=0; end
    end
end
endmodule