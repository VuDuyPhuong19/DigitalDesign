module calendar(
	input clk_day,
	input rst_calendar,
	input stop,
    input adjust_clk,
	output reg [4:0] one_date,
	output reg [4:0] ten_date,
	output reg [4:0] one_month,
	output reg [4:0] ten_month,
	output reg [4:0] one_year,
	output reg [4:0] ten_year,
	output reg [4:0] hundred_year,
	output reg [4:0] million_year
);
localparam MAX_T=9;
localparam MAX_D=3;
localparam MAX_K=2;
reg [14:0] all_year;
reg nhuan=0;
wire intermediate_clk;
// Chọn clock dựa trên trạng thái của stop
assign intermediate_clk = stop ? adjust_clk : clk_day;
always @(posedge intermediate_clk or negedge rst_calendar) begin
	if(~rst_calendar) begin
		one_date<=0;
		ten_date<=0;
		one_month<=1;
		ten_month<=0;
		one_year<=0;
		ten_year<=0;
		hundred_year<=0;
		million_year<=0;
	end
	else begin
		all_year<=one_year+ten_year*10+hundred_year*100+million_year*1000; //tao co nam nhuan
		if((all_year%4)==0) begin
			if(~(all_year%100)) begin
				if(~(all_year%400)) begin
					nhuan<=1;
				end
				else begin
					nhuan<=0;
				end
			end
			else begin
			nhuan<=1;
			end
		end
		else begin
		nhuan<=0;
		end
		if((one_month==2) && (ten_month==0)) begin // xu ly thang 2
			if(nhuan) begin
				if((one_date==9) && (ten_date==2)) begin
					one_date<=0;
					ten_date<=0;
					one_month<=one_month+1;
				end
				else begin
					if(one_date==MAX_T) begin
						ten_date<=ten_date+1;
						one_date<=0;
					end
					else begin
						one_date<=one_date+1;
					end
				end
			end
			else begin
				if((one_date==8) && (ten_date==2)) begin
					one_date<=0;
					ten_date<=0;
					one_month<=one_month+1;
				end
				else begin
					if(one_date==MAX_T) begin // xu ly ngay bthg
						ten_date<=ten_date+1;
						one_date<=0;
					end
					else begin
						one_date<=one_date+1;
					end
				end
			end
		end
		else begin
			if((one_month==1 && ten_month==0) || one_month==3 || one_month == 5 || one_month==7 || one_month==8 || one_month==0 || one_month==2) begin // xu thang co 31 ngay
				if((ten_date==3) && (one_date ==1)) begin //xu ly ngay 31
					ten_date<=0;
					one_date<=0;
					if(one_month==2) begin // xu ly thang 12
						one_month<=1;
						ten_month<=0;
						if(one_year==MAX_T) begin
							if(ten_year==MAX_T) begin// xu ly nam
								if(hundred_year==MAX_T) begin
									if(million_year==MAX_T) begin 
										one_year<=0;
										ten_year<=0;
										hundred_year<=0;
										million_year<=0;
									end
									else begin
									million_year<=million_year+1;
									hundred_year<=0;
									end
								end
								else begin 
									hundred_year<=hundred_year+1;
									ten_year<=0;
								end
							end
							else begin
								ten_year<=ten_year+1;
								one_year<=0;
							end
						end
						else begin
							one_year<=one_year+1;
						end
					end
					else begin
					   one_month<=one_month+1; //khong co truong hop one_month=max nen khong can xu ly chuyen hang chuc cua thang
					end
				end
				else begin 
					if(one_date==MAX_T) begin // xu ly ngay bthg
						ten_date<=ten_date+1;
						one_date<=0;
					end
					else begin
						one_date<=one_date+1;
					end
				end
			end
			else begin
				if((ten_date==3) && (one_date ==0)) begin // cac thang con lai la thang co 30 ngay
					ten_date<=0;
					one_date<=0;
					if(one_month==9) begin //xu ly thang 9
						ten_month<=1;
						one_month<=0;
					end
					else begin // cac thang khac
						one_month<=one_month+1;
					end
				end
				else begin
					if(one_date==MAX_T) begin // xu ly ngay bthg
						ten_date<=ten_date+1;
						one_date<=0;
					end
					else begin
						one_date<=one_date+1;
					end
				end
			end
		end
	end
end
endmodule
`timescale 1ns/1ps
module calendar_test_bench();
reg clk,rst;
wire [6:0] led_1;
wire [6:0] led_2;
wire [6:0] led_3;
wire [6:0] led_4;
wire [6:0] led_5;
wire [6:0] led_6;
wire [6:0] led_7;
wire [6:0] led_8;
wire clk_min;
initial begin
  clk=0;
  forever clk= #200 ~clk;
end
calendar display(
  .clk_day(clk),
  .rst_calendar(rst),
  .one_date(led_1),
  .ten_date(led_2),
  .one_month(led_3),
  .ten_month(led_4),
  .one_year(led_5),
  .ten_year(led_6),
  .hundred_year(led_7),
  .million_year(led_8)
);
initial
begin
rst=1;
#2 rst=0;
#7 rst=1;
#6;
end
endmodule