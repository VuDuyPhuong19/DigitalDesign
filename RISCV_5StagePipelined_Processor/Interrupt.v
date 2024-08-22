module Interrupt #(
    parameter PRIORITY_NMI = 5'd31, 
    parameter PRIORITY_FAST = 5'd30,
    parameter PRIORITY_EXTERNAL = 5'd11,
    parameter PRIORITY_TIMER = 5'd7,
    parameter PRIORITY_SOFTWARE = 5'd3
) (
    input wire clk,
    input wire rst_n,
    input wire irq_nm_i,               // Non-maskable interrupt (ID: 31)
    input wire [14:0] irq_fast_i,      // Fast local interrupts (ID: 30:16)
    input wire irq_external_i,         // External interrupt (ID: 11)
    input wire irq_timer_i,            // Timer interrupt (ID: 7)
    input wire irq_software_i,         // Software interrupt (ID: 3)
    input wire irq_done,               // Tín hiệu báo hiệu ngắt đã hoàn tất
    input wire [31:0] pc_in_irq,           // PC hiện tại
    output reg [31:0] pc_out_irq,          // PC output cho luồng ngắt
    output reg irq_active,             // Tín hiệu báo rằng một ngắt đang được xử lý
    output reg control_pc_irq            // Tín hiệu điều khiển để chọn PC
    //output reg [4:0] irq_id            // ID của ngắt hiện tại đang xử lý
);

    

    reg [4:0] highest_priority_irq;
    reg [31:0] irq_vector_addr;
    reg [31:0] saved_pc;
    reg trigger;




    // Bảng vector ngắt
    always @(highest_priority_irq) begin
        case (highest_priority_irq)
            PRIORITY_NMI:       irq_vector_addr = 32'h00000010;
            PRIORITY_FAST:      irq_vector_addr = 32'h00000020;
            PRIORITY_EXTERNAL:  irq_vector_addr = 32'h00000030;
            PRIORITY_TIMER:     irq_vector_addr = 300;
            PRIORITY_SOFTWARE:  irq_vector_addr = 32'h00000050;
            default:            irq_vector_addr = 32'h00000000;
        endcase
    end

    // Xác định ngắt có độ ưu tiên cao nhất
    always @(irq_timer_i) begin
        // if (irq_nm_i)
        //     highest_priority_irq = PRIORITY_NMI;
        // else if (irq_fast_i != 15'b0)
        //     highest_priority_irq = PRIORITY_FAST;
        // else if (irq_external_i)
        //     highest_priority_irq = PRIORITY_EXTERNAL;
        // else if (irq_timer_i)
        //     highest_priority_irq = PRIORITY_TIMER;
        // else if (irq_software_i)
        //     highest_priority_irq = PRIORITY_SOFTWARE;
        // else
        //     highest_priority_irq = 5'd0;
//-----------------------------only_timer-----------------------//
        if (irq_timer_i)
             highest_priority_irq = PRIORITY_TIMER;
         else highest_priority_irq = 5'd0;
    end

    // FSM để xử lý ngắt
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pc_out_irq <= 32'h00000024;
            irq_active <= 1'b0;
            control_pc_irq <= 1'b0;
            saved_pc <= 32'b0;          
        end else begin
            if (!irq_active) begin
                if (highest_priority_irq != 5'b0) begin
                    // Lưu PC hiện tại và chuyển đến handler ngắt
                    saved_pc <= pc_in_irq + 4;
                    pc_out_irq <= irq_vector_addr;
                    irq_active <= 1'b1;
                    //irq_id <= highest_priority_irq;
                    control_pc_irq <= 1'b1; // Điều khiển PC đến địa chỉ ngắt
                end 
            end else if (irq_done) begin
                // Phục hồi PC và kết thúc xử lý ngắt
                pc_out_irq <= saved_pc;
                irq_active <= 1'b0;
                control_pc_irq <= 1'b1; // Điều khiển PC trở lại luồng chính
                //irq_id <= 5'b0;
            end else begin
                control_pc_irq <= 1'b0; // Không thay đổi PC nếu không có ngắt mới và không có IRQ done
            end
        end
    end

    always @(negedge irq_done) begin
        trigger <=1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            trigger <=0;
     end else begin
        if (trigger) begin 
            control_pc_irq<=0;
         end
        end
     end
endmodule


