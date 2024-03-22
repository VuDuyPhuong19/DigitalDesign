
module majority
 #(parameter n=8 )// khai báo h?ng s?, c?u hình cho m?ch

(
	input [n-1:0] x,  // S? d?ng tham s? n ?? xác ??nh kích th??c c?a x
	output y
);
// Khai báo và s?a ch?a cú pháp cho cnt và thêm bi?n ??m i
integer i;
// ki?m tra s? "bit 1" >4
reg [2:0] cnt; // S? d?ng clog2() cho vi?c tính toán s? bit c?n thi?t ?? bi?u di?n cnt

always @(x)
begin
	cnt = 0; // Kh?i t?o cnt = 0 m?i khi x thay ??i
	

for( i=0; i<n; i=i+1 )
	begin 
	if( x[i] ) cnt=cnt+1; // Ch? t?ng cnt n?u x[i] là 1
	end
	
end
assign y=(cnt>=n/2) ?1'b1:1'b0;
endmodule