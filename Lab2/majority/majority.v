module majority #(parameter n = 8)(
	input [n - 1:0] x,
	output y
);

integer i;
reg [$clog2(n) - 1:0] cnt;

always @ (x) begin
  cnt  = 0;
	for(i = 0; i < n; i = i + 1) begin
		if(x[i]) cnt = cnt + 1;
	end
end

assign y = (cnt > n/2) ? 1'b1 : 1'b0;

endmodule

