module testbench_full_adder;

// Declare testbench variables 
	reg [3:0] stim_a, stim_b;
	reg stim_c_in;
	wire mon_c_out;
	wire [3:0] mon_s;
	integer i;
// Instantiate the design and connect to testbench variables
	full_adder tb_adder(
		.a(stim_a),
		.b(stim_b),
		.c_in(stim_c_in),
		.c_out(mon_c_out),
		.s(mon_s)
	);

// Provide stimulus to test the design 
	initial begin 
		stim_a <= 0;
		stim_b <= 0;
		stim_c_in <= 0;
		
		$monitor("stim_a=%d stim_b=%d stim_c_in=%d mon_c_out=%d mon_s=%d", stim_a, stim_b, stim_c_in, mon_c_out, mon_s);
		#10
		for (i = 0; i < 5; i = i + 1) begin
			 stim_a <= i;
				 stim_b <= i + 10;
				 stim_c_in <= mon_c_out;
				 #10;
		end
	end
endmodule 
	
	
