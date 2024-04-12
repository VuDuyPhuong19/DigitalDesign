module coeffs #(
	parameter NUMTABS = 31
)(
	input [4:0] count,
	output signed [15:0] coeffs_in
);

localparam coeffs_0 =  16'b0000000000000000; 
localparam coeffs_1 =  16'b0000000000010011;
localparam coeffs_2 =  16'b0000000000101101;
localparam coeffs_3 =  16'b0000000001000101;
localparam coeffs_4 =  16'b0000000001000000;
localparam coeffs_5 =  16'b1000000000000000;
localparam coeffs_6 =  16'b1000000010000111;
localparam coeffs_7 =  16'b1000000100110000;
localparam coeffs_8 =  16'b1000000110011111;
localparam coeffs_9 =  16'b1000000101011011;
localparam coeffs_10 = 16'b0000000000000000;
localparam coeffs_11 = 16'b0000001010001000;
localparam coeffs_12 = 16'b0000010111100001;
localparam coeffs_13 = 16'b0000100101001001;
localparam coeffs_14 = 16'b0000101111010101;
localparam coeffs_15 = 16'b0000110011000111;
localparam coeffs_16 = 16'b0000101111010101;
localparam coeffs_17 = 16'b0000100101001001;
localparam coeffs_18 = 16'b0000010111100001;
localparam coeffs_19 = 16'b0000001010001000;
localparam coeffs_20 = 16'b0000000000000000;
localparam coeffs_21 = 16'b1000000101011011;
localparam coeffs_22 = 16'b1000000110011111;
localparam coeffs_23 = 16'b1000000100110000;
localparam coeffs_24 = 16'b1000000010000111;
localparam coeffs_25 = 16'b1000000000000000;
localparam coeffs_26 = 16'b0000000001000000;
localparam coeffs_27 = 16'b0000000001000101;
localparam coeffs_28 = 16'b0000000000101101;
localparam coeffs_29 = 16'b0000000000010011;
localparam coeffs_30 = 16'b0000000000000000;

assign coeffs_in = 	(count == 5'b00000) ? coeffs_0 :
					(count == 5'b00001) ? coeffs_1 :
					(count == 5'b00010) ? coeffs_2 :
					(count == 5'b00011) ? coeffs_3 :
					(count == 5'b00100) ? coeffs_4 :
					(count == 5'b00101) ? coeffs_5 :
					(count == 5'b00110) ? coeffs_6 :
					(count == 5'b00111) ? coeffs_7 :
					(count == 5'b01000) ? coeffs_8 :
					(count == 5'b01001) ? coeffs_9 :
					(count == 5'b01010) ? coeffs_10 :
					(count == 5'b01011) ? coeffs_11 :
					(count == 5'b01100) ? coeffs_12 :
					(count == 5'b01101) ? coeffs_13 :
					(count == 5'b01110) ? coeffs_14 :
					(count == 5'b01111) ? coeffs_15 :
					(count == 5'b10000) ? coeffs_16 :
					(count == 5'b10001) ? coeffs_17 :
					(count == 5'b10010) ? coeffs_18 :
					(count == 5'b10011) ? coeffs_19 :
					(count == 5'b10100) ? coeffs_20 :
					(count == 5'b10101) ? coeffs_21 :
					(count == 5'b10110) ? coeffs_22 :
					(count == 5'b10111) ? coeffs_23 :
					(count == 5'b11000) ? coeffs_24 :
					(count == 5'b11001) ? coeffs_25 :
					(count == 5'b11010) ? coeffs_26 :
					(count == 5'b11011) ? coeffs_27 :
					(count == 5'b11100) ? coeffs_28 :
					(count == 5'b11101) ? coeffs_29 :
					(count == 5'b11110) ? coeffs_30 :
					(count == 5'b11111) ? 16'b0000000000000000 : 16'b0000000000000000;
endmodule