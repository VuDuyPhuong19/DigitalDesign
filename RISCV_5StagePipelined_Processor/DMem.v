// module DMem #(
// 	parameter ADDR_WIDTH = 32,
// 	parameter DMEM_WIDTH = 32,
// 	parameter DMEM_DEPTH = 1 << 6 // 1 << 32
// )(
// 	input clk, 
// 	input rst_n,
// 	input MemWrite,
// 	input [ADDR_WIDTH-1:0] addr,
// 	input [DMEM_WIDTH-1:0] write_data,
// 	output [DMEM_WIDTH-1:0] read_data
// );

// reg [DMEM_WIDTH-1:0] dmem [DMEM_DEPTH-1:0];

// assign read_data = (!MemWrite) ? dmem[addr] : 32'b0;

// integer i;
// always @ (posedge clk or negedge rst_n) begin
// 	if(~rst_n) begin
		// for (i = 0; i < DMEM_DEPTH; i = i + 1) begin
		// 	dmem[i] <= 32'b0;
		// end
// 	end
// 	else if (MemWrite) begin
// 		dmem[addr] = write_data;
// 	end
// end

// endmodule

module DMem #(
    parameter ADDR_WIDTH = 32,
    parameter DMEM_WIDTH = 32,
    parameter DMEM_DEPTH = 1 << 10 // 64 words
) (
    input clk,
    input rst_n,
    input MemWrite,
    input [ADDR_WIDTH-1:0] addr,
    input [DMEM_WIDTH-1:0] write_data,
    input [1:0] write_type_M, // 00: byte, 01: halfword, 10: word
    output [DMEM_WIDTH-1:0] read_data
);

reg [DMEM_WIDTH-1:0] memory [DMEM_DEPTH-1:0];
integer i;

// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         read_data <= 32'b0;
//     end else begin
//         read_data <= memory[addr >> 2];
//     end
// end

assign read_data = (!MemWrite) ? memory[addr >> 2] : 32'b0;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < DMEM_DEPTH; i = i + 1) begin
            memory[i] <= 32'b0;
        end
    end else if (MemWrite) begin
        case (write_type_M)
            2'b00: begin // SB
                case (addr[1:0])
                    2'b00: memory[addr >> 2][7:0] <= write_data[7:0];
                    2'b01: memory[addr >> 2][15:8] <= write_data[7:0];
                    2'b10: memory[addr >> 2][23:16] <= write_data[7:0];
                    2'b11: memory[addr >> 2][31:24] <= write_data[7:0];
                endcase
            end
            2'b01: begin // SH
                if (addr[1] == 0) begin
                    memory[addr >> 2][15:0] <= write_data[15:0];
                end else begin
                    memory[addr >> 2][31:16] <= write_data[15:0];
                end
            end
            2'b10: memory[addr >> 2] <= write_data; // SW
        endcase
    end
end

endmodule

