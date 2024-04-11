module  filter
#parameter (
    k=8;
    a0=3;
    a=7
)

#parameter [7:0] a [TOTAL-1 : 0]   = {8'd1, 8'd0, 8'd0, 8'd2};

 (
    input clk,
    input rst_n,
    input  [7:0] g,
    input [24:0]s,
    input [15:0]x,
    output reg [15:0] y
);
    reg [15:0] delay_x[0:k];
    integer  i;;
    always @( posedge clk or rst_n ) begin
        if (rst_n) begin
            // reset
            y<=0;
      
            for ( i= 1;i<k ;i=i+1 ) begin
                delay_x[i]<= 0;
            end
        end
             if macro
            
        else    begin  
             for ( i= 1;i<k ;i=i+1 ) begin
                delay_x[i]<= delay_x[i-1];
                delay_x[0]<=x;
        end
        y<=a0*x +a1*delay_x[0]+a2*delay_x[1]+.....
        s<= s+ a[i] + delay_x[i];
    end
    end
    always  @(x or delay_x) begin 
        s=a[0]*x;
        for ( i= 1;i<k ;i=i+1 ) begin
            s=a[i]*delay_x[i];
        end
    end

endmodule