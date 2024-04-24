module MinuteCounter(
    input clk,     // Clock input, được kích hoạt mỗi khi một phút trôi qua
    input reset,   // Reset input để đặt lại bộ đếm về 0
    output reg [5:0] minute = 0, // 6-bit output cho giá trị phút
output reg one_hour =0// Output that indicates a hour has passed
);

always @(posedge clk or negedge reset) begin
    if (~reset) begin
        // Nếu reset, đặt lại giá trị phút về 0
        minute <= 40;
		  one_hour<=0;
    end else if (minute == 59) begin
        // Nếu đạt đến 59 phút, quay lại 0
        minute <= 0;
		  one_hour<=1;
    end else begin
        // Nếu không, tăng giá trị phút lên 1
        minute <= minute + 1;
		  one_hour<=0;
    end
end

endmodule
