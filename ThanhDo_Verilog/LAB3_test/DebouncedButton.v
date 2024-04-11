module DebouncedButton(
    input clk,        // Clock input, e.g., 50MHz
    input reset,      // Reset input
    input noisyButton,// Noisy button input
    output reg cleanButton // Debounced button output
);

parameter DEBOUNCE_TIME = 20_000_000; // Thời gian debounce, ví dụ 20 triệu chu kỳ clock (~400ms tại 50MHz)
reg [31:0] counter;    // Bộ đếm để thực hiện debounce
reg buttonState;       // Trạng thái hiện tại của nút sau khi debounce
reg lastButtonState;   // Trạng thái trước đó của nút

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        buttonState <= 0;
        lastButtonState <= 0;
        cleanButton <= 0;
    end
    else begin
        // Kiểm tra xem nút có thay đổi trạng thái không
        if (noisyButton != lastButtonState) begin
            // Nếu có, bắt đầu hoặc tiếp tục đếm
            counter <= counter + 1;
            // Kiểm tra xem bộ đếm đã đạt tới thời gian debounce chưa
            if (counter >= DEBOUNCE_TIME) begin
                // Cập nhật trạng thái nút và reset bộ đếm
                buttonState <= noisyButton;
                counter <= 0;
            end
        end
        else begin
            // Nếu không có sự thay đổi, reset bộ đếm
            counter <= 0;
        end
        // Cập nhật trạng thái cuối cùng của nút và đầu ra
        cleanButton <= buttonState;
        lastButtonState <= noisyButton;
    end
end

endmodule
