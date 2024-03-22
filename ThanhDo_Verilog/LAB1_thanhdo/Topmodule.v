module Topmodule (
	input wire [15:0] in,
	output wire [27:0] out
	);
	Bin27Seg led1( in[3:0],   out[6:0]   );
	Bin27Seg led2( in[7:4],   out[13:7]  );
	Bin27Seg led3( in[11:8],  out[20:14] );
	Bin27Seg led4( in[15:12], out[27:21] );
endmodule
