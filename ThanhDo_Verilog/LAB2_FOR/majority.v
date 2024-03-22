module majority
 #(parameter n=8 )// khai báo hằng số, cấu hình cho mạch

(
	input [n-1:0] x,  // Sử dụng tham số n để xác định kích thước của x
	output y
);
// Khai báo và sửa chữa cú pháp cho cnt và thêm biến đếm i
integer i;
// kiểm tra số "bit 1" >4
reg [2:0] cnt; // Sử dụng clog2() cho việc tính toán số bit cần thiết để biểu diễn cnt

always @(x)
begin
	cnt = 0; // Khởi tạo cnt = 0 mỗi khi x thay đổi
	

for( i=0; i<n; i=i+1 )
	begin 
	if( x[i] ) cnt=cnt+1; // Chỉ tăng cnt nếu x[i] là 1
	end
	
end
assign y=(cnt>=n/2) ?1'b1:1'b0;
endmodule