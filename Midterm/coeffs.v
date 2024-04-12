module coeffs #(
	parameter NUMTABS = 64,
	parameter COUNT_BIT_NUM = $clog2(NUMTABS)
)(
	input [COUNT_BIT_NUM-1:0] count,
	output signed [15:0] coeffs_in
);

localparam coeffs_0 =  16'b0000000000001111; 
localparam coeffs_1 =  16'b0000000000010010;
localparam coeffs_2 =  16'b0000000000010101;
localparam coeffs_3 =  16'b0000000000011001;
localparam coeffs_4 =  16'b0000000000100000;
localparam coeffs_5 =  16'b0000000000101000;
localparam coeffs_6 =  16'b0000000000110010;
localparam coeffs_7 =  16'b0000000000111110;
localparam coeffs_8 =  16'b0000000001001101;
localparam coeffs_9 =  16'b0000000001011110;
localparam coeffs_10 = 16'b0000000001110001;
localparam coeffs_11 = 16'b0000000010000110;
localparam coeffs_12 = 16'b0000000010011101;
localparam coeffs_13 = 16'b0000000010110110;
localparam coeffs_14 = 16'b0000000011010001;
localparam coeffs_15 = 16'b0000000011101110;
localparam coeffs_16 = 16'b0000000100001011;
localparam coeffs_17 = 16'b0000000100101001;
localparam coeffs_18 = 16'b0000000101001000;
localparam coeffs_19 = 16'b0000000101100111;
localparam coeffs_20 = 16'b0000000110000110;
localparam coeffs_21 = 16'b0000000110100100;
localparam coeffs_22 = 16'b0000000111000001;
localparam coeffs_23 = 16'b0000000111011100;
localparam coeffs_24 = 16'b0000000111110101;
localparam coeffs_25 = 16'b0000001000001101;
localparam coeffs_26 = 16'b0000001000100001;
localparam coeffs_27 = 16'b0000001000110011;
localparam coeffs_28 = 16'b0000001001000001;
localparam coeffs_29 = 16'b0000001001001100;
localparam coeffs_30 = 16'b0000001001010011;
localparam coeffs_31 = 16'b0000001001010111;
localparam coeffs_32 = 16'b0000001001010111;
localparam coeffs_33 = 16'b0000001001010011;
localparam coeffs_34 = 16'b0000001001001100;
localparam coeffs_35 = 16'b0000001001000001;
localparam coeffs_36 = 16'b0000001000110011;
localparam coeffs_37 = 16'b0000001000100001;
localparam coeffs_38 = 16'b0000001000001101;
localparam coeffs_39 = 16'b0000000111110101;
localparam coeffs_40 = 16'b0000000111011100;
localparam coeffs_41 = 16'b0000000111000001;
localparam coeffs_42 = 16'b0000000110100100;
localparam coeffs_43 = 16'b0000000110000110;
localparam coeffs_44 = 16'b0000000101100111;
localparam coeffs_45 = 16'b0000000101001000;
localparam coeffs_46 = 16'b0000000100101001;
localparam coeffs_47 = 16'b0000000100001011;
localparam coeffs_48 = 16'b0000000011101110;
localparam coeffs_49 = 16'b0000000011010001;
localparam coeffs_50 = 16'b0000000010110110;
localparam coeffs_51 = 16'b0000000010011101;
localparam coeffs_52 = 16'b0000000010000110;
localparam coeffs_53 = 16'b0000000001110001;
localparam coeffs_54 = 16'b0000000001011110;
localparam coeffs_55 = 16'b0000000001001101;
localparam coeffs_56 = 16'b0000000000111110;
localparam coeffs_57 = 16'b0000000000110010;
localparam coeffs_58 = 16'b0000000000101000;
localparam coeffs_59 = 16'b0000000000100000;
localparam coeffs_60 = 16'b0000000000011001;
localparam coeffs_61 = 16'b0000000000010101;
localparam coeffs_62 = 16'b0000000000010010;
localparam coeffs_63 = 16'b0000000000001111;



assign coeffs_in = 	(count == 6'b000000) ? coeffs_0 :
					(count == 6'b000001) ? coeffs_1 :
					(count == 6'b000010) ? coeffs_2 :
					(count == 6'b000011) ? coeffs_3 :
					(count == 6'b000100) ? coeffs_4 :
					(count == 6'b000101) ? coeffs_5 :
					(count == 6'b000110) ? coeffs_6 :
					(count == 6'b000111) ? coeffs_7 :
					(count == 6'b001000) ? coeffs_8 :
					(count == 6'b001001) ? coeffs_9 :
					(count == 6'b001010) ? coeffs_10 :
					(count == 6'b001011) ? coeffs_11 :
					(count == 6'b001100) ? coeffs_12 :
					(count == 6'b001101) ? coeffs_13 :
					(count == 6'b001110) ? coeffs_14 :
					(count == 6'b001111) ? coeffs_15 :
					(count == 6'b010000) ? coeffs_16 :
					(count == 6'b010001) ? coeffs_17 :
					(count == 6'b010010) ? coeffs_18 :
					(count == 6'b010011) ? coeffs_19 :
					(count == 6'b010100) ? coeffs_20 :
					(count == 6'b010101) ? coeffs_21 :
					(count == 6'b010110) ? coeffs_22 :
					(count == 6'b010111) ? coeffs_23 :
					(count == 6'b011000) ? coeffs_24 :
					(count == 6'b011001) ? coeffs_25 :
					(count == 6'b011010) ? coeffs_26 :
					(count == 6'b011011) ? coeffs_27 :
					(count == 6'b011100) ? coeffs_28 :
					(count == 6'b011101) ? coeffs_29 :
					(count == 6'b011110) ? coeffs_30 :
					(count == 6'b011111) ? coeffs_31 :
					(count == 6'b100000) ? coeffs_32 :
					(count == 6'b100001) ? coeffs_33 :
					(count == 6'b100010) ? coeffs_34 :
					(count == 6'b100011) ? coeffs_35 :
					(count == 6'b100100) ? coeffs_36 :
					(count == 6'b100101) ? coeffs_37 :
					(count == 6'b100110) ? coeffs_38 :
					(count == 6'b100111) ? coeffs_39 :
					(count == 6'b101000) ? coeffs_40 :
					(count == 6'b101001) ? coeffs_41 :
					(count == 6'b101010) ? coeffs_42 :
					(count == 6'b101011) ? coeffs_43 :
					(count == 6'b101100) ? coeffs_44 :
					(count == 6'b101101) ? coeffs_45 :
					(count == 6'b101110) ? coeffs_46 :
					(count == 6'b101111) ? coeffs_47 :
					(count == 6'b110000) ? coeffs_48 :
					(count == 6'b110001) ? coeffs_49 :
					(count == 6'b110010) ? coeffs_50 :
					(count == 6'b110011) ? coeffs_51 :
					(count == 6'b110100) ? coeffs_52 :
					(count == 6'b110101) ? coeffs_53 :
					(count == 6'b110110) ? coeffs_54 :
					(count == 6'b110111) ? coeffs_55 :
					(count == 6'b111000) ? coeffs_56 :
					(count == 6'b111001) ? coeffs_57 :
					(count == 6'b111010) ? coeffs_58 :
					(count == 6'b111011) ? coeffs_59 :
					(count == 6'b111100) ? coeffs_60 :
					(count == 6'b111101) ? coeffs_61 :
					(count == 6'b111110) ? coeffs_62 :
					(count == 6'b111111) ? coeffs_63 : 16'b0000000000000000;
endmodule