module testbench_majority #(parameter m = 8);

reg [m - 1:0] stim_x;
wire mon_y;

majority testbench(
	.x(stim_x),
	.y(mon_y)
);

initial begin 
  stim_x = 0;
  #10
	$monitor("stim_x=%d mon_y=%d", stim_x, mon_y);
	stim_x = 8'b00000111;
	#10
	stim_x = 8'b11110000;
	#10
	stim_x = 8'b00011111;
	#10;
end
endmodule
