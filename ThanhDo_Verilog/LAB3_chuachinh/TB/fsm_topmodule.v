
module fsm_topmodule(
    input x,
    input clk,
    input rst_n,
    output reg y
);

    localparam WAIT_1ST_1 = 2'b00,  // Tr?ng th�i ch? bit ??u ti�n l� 1
               WAIT_0     = 2'b01,  // Tr?ng th�i ch? bit 0
               WAIT_2ND_1 = 2'b10;  // Tr?ng th�i ch? bit th? hai l� 1

    reg [1:0] state = WAIT_1ST_1, nextstate;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= WAIT_1ST_1;  // N?u reset, quay v? tr?ng th�i ban ??u
            y <= 0;               // v� ??t y v? 0
        end
        else begin
            state <= nextstate;   // C?p nh?t tr?ng th�i m?i d?a tr�n x v� tr?ng th�i hi?n t?i
        end
    end

    always @(*) begin
        nextstate = state;  // Gi� tr? m?c ??nh cho nextstate ?? tr�nh latching
        y = 0;              // Gi� tr? m?c ??nh cho y

        case (state)
            WAIT_1ST_1: begin
                if (x == 1) nextstate = WAIT_0;  // N?u x = 1, chuy?n sang tr?ng th�i ti?p theo
                else nextstate = WAIT_1ST_1; 
            end
            WAIT_0: begin
                if (x == 0) nextstate = WAIT_2ND_1;  // N?u x = 0, chuy?n sang tr?ng th�i ti?p theo
                else nextstate = WAIT_0;         // N?u x l?i l� 1, quay l?i ch? bit ??u ti�n
            end
            WAIT_2ND_1: begin
                if (x == 1) begin
                    y = 1;                         // N?u x = 1, chu?i 101 ?� ???c ph�t hi?n
                    nextstate = WAIT_0;        // Quay l?i ch? bit ??u ti�n
                end
                else nextstate = WAIT_1ST_1;           // N?u x = 0, chuy?n sang tr?ng th�i ch? 0
            end
        endcase
    end

endmodule

