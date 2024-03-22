module if_else(
	input [7:0] a,b,
	input [1:0]s1,
	output reg [7:0] y
);
always@(a or b or s1)
begin 
//if else không lồng nhau
/*
	if(s1==2'b00)
		y=a*b;
	else y=0; //y la muon khong thuc hien gi de thuc hien cai tiep theo
	if(s1==2'b01)
		y=a-b;
	else y=0;
	if(s1==2'b11)
		y=~a;
	else y=0;
	if(s1==2'b10)
		y=a+b;
	else y=0;
	*/
// if else lồng nhau
/*
	if(s1==2'b00)
		y=a*b;
	else if (s1==2'b01)
				y=a-b;
			else if(s1==2'b10)
						y=~a;
					else y=a+b;
*/
// switch case do casex casey casez không khác gì trong trường hợp này nên em không làm ra file khác ạ
	casez(s1) 
		2'b00:y=a*b;
		2'b01:y=a-b;
		2'b10:y=~a;
		default: y=a+b;
		endcase
end
endmodule
	