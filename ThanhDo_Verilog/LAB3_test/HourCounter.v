module HourCounter(
    input clk,
    input reset,
    input key1, // Nút để tạm dừng và tăng giờ
	 input key2,
	 input key3,
    output reg [4:0] hour,
    output reg one_day = 0
);

reg paused = 0; // Biến để theo dõi trạng thái tạm dừng
reg last_key1_state = 0; // Lưu trạng thái cuối cùng của key1 để phát hiện cạnh lên

// Phát hiện cạnh lên của key1 và xử lý
always @(posedge clk or negedge reset) begin
    if (~reset) begin
        hour <= 10;
        one_day <= 0;
        paused <= 0;
        last_key1_state <= 0;
    end else begin
        if (~key1) begin // Phát hiện cạnh lên
            paused <= 1; // Đảo trạng thái tạm dừng
            if (paused) begin
                // Chỉ tăng giờ khi ở chế độ tạm dừng và nhấn nút
                if (hour == 23) begin
                    hour <= 0;
                    one_day <= 1;
                end else begin
                    hour <= hour + 1;
                    one_day <= 0;
                end
            end
        end else if (~key2) begin // Phát hiện cạnh lên
            paused <= 1; // Đảo trạng thái tạm dừng
            if (paused) begin
                // Chỉ tăng giờ khi ở chế độ tạm dừng và nhấn nút
                if (hour == 23) begin
                    hour <= 0;
                    one_day <= 1;
                end else begin
                    hour <= hour + 10;
                    one_day <= 0;
                end
            end
        end else if (~key3)  paused <= 0;
		  else
		  if (!paused) begin
            // Đếm bình thường khi không ở chế độ tạm dừng
            if (hour == 23) begin
                hour <= 0;
                one_day <= 1;
            end else begin
                hour <= hour + 1;
                one_day <= 0;
            end
        end
        last_key1_state <= key1; // Cập nhật trạng thái cuối của key1
    end
end

endmodule
