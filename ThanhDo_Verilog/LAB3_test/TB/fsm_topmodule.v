
module fsm_topmodule(
    input x,
    input clk,
    input rst_n,
    output reg y
);

    localparam WAIT_1ST_1 = 2'b00,  // Tr?ng thái ch? bit ??u tiên là 1
               WAIT_0     = 2'b01,  // Tr?ng thái ch? bit 0
               WAIT_2ND_1 = 2'b10;  // Tr?ng thái ch? bit th? hai là 1

    reg [1:0] state = WAIT_1ST_1, nextstate;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= WAIT_1ST_1;  // N?u reset, quay v? tr?ng thái ban ??u
            y <= 0;               // và ??t y v? 0
        end
        else begin
            state <= nextstate;   // C?p nh?t tr?ng thái m?i d?a trên x và tr?ng thái hi?n t?i
        end
    end

    always @(*) begin
        nextstate = state;  // Giá tr? m?c ??nh cho nextstate ?? tránh latching
        y = 0;              // Giá tr? m?c ??nh cho y

        case (state)
            WAIT_1ST_1: begin
                if (x == 1) nextstate = WAIT_0;  // N?u x = 1, chuy?n sang tr?ng thái ti?p theo
                else nextstate = WAIT_1ST_1; 
            end
            WAIT_0: begin
                if (x == 0) nextstate = WAIT_2ND_1;  // N?u x = 0, chuy?n sang tr?ng thái ti?p theo
                else nextstate = WAIT_0;         // N?u x l?i là 1, quay l?i ch? bit ??u tiên
            end
            WAIT_2ND_1: begin
                if (x == 1) begin
                    y = 1;                         // N?u x = 1, chu?i 101 ?ã ???c phát hi?n
                    nextstate = WAIT_0;        // Quay l?i ch? bit ??u tiên
                end
                else nextstate = WAIT_1ST_1;           // N?u x = 0, chuy?n sang tr?ng thái ch? 0
            end
        endcase
    end

endmodule

