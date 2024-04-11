

`timescale 1ns / 1ps

module fsm_tb ();

// Khai b�o c�c bi?n s? ???c s? d?ng l�m ??u v�o cho DUT (Device Under Test)
reg x;
reg clk;
reg rst_n;

// Khai b�o bi?n ?? theo d�i ??u ra t? DUT
wire y;

// Kh?i t?o instance c?a DUT
fsm_topmodule dut (
    .x(x), 
    .clk(clk), 
    .rst_n(rst_n), 
    .y(y)
);

// Kh?i t?o clock
initial begin
    clk = 0;
    forever #10 clk = ~clk; // T?o xung clock v?i chu k? 20ns
end

// (T�y ch?n) In gi� tr? c?a y khi c� s? thay ??i
initial begin
    $monitor("At time %t, output y = %d", $time, y);
end

// Kh?i t?o test
initial begin
    // Kh?i t?o t�n hi?u
    rst_n = 0; x = 0;
    
    // Reset DUT
    #20 rst_n = 1;
    
    // Ki?m tra tr?ng th�i chuy?n ??i c?a FSM
    #20 x = 1;
    #20 x = 0;
    #20 x = 1;
    #20 x = 0;
    #20 x = 1;
    #20 x = 0;
    #20 x = 1;
    #20 x = 0;
    #20 x = 1;
    #20 x = 0;
    #20 x = 1;
    #20 x = 0;
    
    // Th�m c�c tr??ng h?p ki?m tra kh�c ? ?�y
    
    //#100; // ??i m?t th?i gian ?? quan s�t k?t qu?
    
    $stop; // K?t th�c m� ph?ng
end



endmodule
