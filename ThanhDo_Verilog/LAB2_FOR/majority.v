
module majority
 #(parameter n=8 )// khai b�o h?ng s?, c?u h�nh cho m?ch

(
	input [n-1:0] x,  // S? d?ng tham s? n ?? x�c ??nh k�ch th??c c?a x
	output y
);
// Khai b�o v� s?a ch?a c� ph�p cho cnt v� th�m bi?n ??m i
integer i;
// ki?m tra s? "bit 1" >4
reg [2:0] cnt; // S? d?ng clog2() cho vi?c t�nh to�n s? bit c?n thi?t ?? bi?u di?n cnt

always @(x)
begin
	cnt = 0; // Kh?i t?o cnt = 0 m?i khi x thay ??i
	

for( i=0; i<n; i=i+1 )
	begin 
	if( x[i] ) cnt=cnt+1; // Ch? t?ng cnt n?u x[i] l� 1
	end
	
end
assign y=(cnt>=n/2) ?1'b1:1'b0;
endmodule