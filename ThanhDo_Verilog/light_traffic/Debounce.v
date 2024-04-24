module Debounce
(
    input clk,
    input reset,
    input D,
    output reg Qout
);

reg Q1, Q2, Q3;

// Sửa lỗi trong việc xử lý sự kiện trong câu lệnh always.
// Cần thêm từ khóa 'posedge' và 'negedge' cùng với sự kiện tương ứng.
always @(posedge clk or negedge reset)
begin 
    if(!reset)  // Sửa lỗi gán giá trị khi reset không hoạt động
        Q1 <= 1'b0; 
    else 
        Q1 <= D; 
end 

always @(posedge clk or negedge reset)
begin 
    if(!reset)
        Q2 <= 1'b0; 
    else 
        Q2 <= Q1; 
end 

always @(posedge clk or negedge reset)
begin 
    if(!reset)
        Q3 <= 1'b0; 
    else 
        Q3 <= Q2; 
end 

always @(posedge clk or negedge reset)
begin 
    if(!reset)
        Qout <= 1'b0; 
    else 
        Qout <= Q3; 
end 

endmodule
