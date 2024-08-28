module compressed_decoder(
    input      [31:0] instr_i,
    output reg [31:0] instr_o
);

    always @ (*) begin
        instr_o = 32'b0;
        case ({instr_i[15:13], instr_i[1:0]})
            // c.addi4spn 
            5'b00000: instr_o = {2'b00, instr_i[10:7], instr_i[12:11], instr_i[5], instr_i[6], 2'b00, 5'd2, 3'b000, 2'b01, instr_i[4:2], 7'b0010011};
            // c.lw 
            5'b01000: instr_o = {5'b00000, instr_i[5], instr_i[12:10], instr_i[6], 2'b00, 2'b01, instr_i[9:7], 3'b010, 2'b01, instr_i[4:2], 7'b0000011};
            // c.sw 
            5'b11000: instr_o = {5'b00000, instr_i[5], instr_i[12], 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b010, instr_i[11:10], instr_i[6], 2'b00, 7'b0100011};
            5'b00001: begin
                // c.nop 
                if (instr_i[12:2] == 11'b0)
                    instr_o = {25'b0, 7'b0010011};
                    // c.addi 
                else instr_o = {{7{instr_i[12]}}, instr_i[6:2], instr_i[11:7], 3'b000, instr_i[11:7], 7'b0010011};
            end
            // c.jal 
            5'b00101: instr_o = {instr_i[12], instr_i[8], instr_i[10:9], instr_i[6], instr_i[7], instr_i[2], instr_i[11], instr_i[5:3], instr_i[12], {8{instr_i[12]}}, 5'd1, 7'b1101111};
            // c.li 
            5'b01001: instr_o = {{7{instr_i[12]}}, instr_i[6:2], 5'd0, 3'b000, instr_i[11:7], 7'b0010011};
            5'b01101: begin
                // c.addi16sp 
                if (instr_i[11:7] == 5'd2)
                    instr_o = {{3{instr_i[12]}}, instr_i[4], instr_i[3], instr_i[5], instr_i[2], instr_i[6], 4'b0000, 5'd2, 3'b000, 5'd2, 7'b0010011};
                    // c.lui 
                else instr_o = {{15{instr_i[12]}}, instr_i[6:2], instr_i[11:7], 7'b0110111};
            end
            5'b10001: begin
                // c.sub 
                if (instr_i[12:10] == 3'b011 && instr_i[6:5] == 2'b00)
                    instr_o = {7'b0100000, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b000, 2'b01, instr_i[9:7], 7'b0110011};
                    // c.xor 
                else if (instr_i[12:10] == 3'b011 && instr_i[6:5] == 2'b01)
                    instr_o = {7'b0000000, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b100, 2'b01, instr_i[9:7], 7'b0110011};
                    // c.or 
                else if (instr_i[12:10] == 3'b011 && instr_i[6:5] == 2'b10)
                    instr_o = {7'b0000000, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b110, 2'b01, instr_i[9:7], 7'b0110011};
                    // c.and 
                else if (instr_i[12:10] == 3'b011 && instr_i[6:5] == 2'b11)
                    instr_o = {7'b0000000, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b111, 2'b01, instr_i[9:7], 7'b0110011};
                    // c.andi 
                else if (instr_i[11:10] == 2'b10)
                    instr_o = {{7{instr_i[12]}}, instr_i[6:2], 2'b01, instr_i[9:7], 3'b111, 2'b01, instr_i[9:7], 7'b0010011};
                    // Skip instruction
                else if (instr_i[12] == 1'b0 && instr_i[6:2] == 5'b0)
                    instr_o = 32'b0;
                    // c.srli 
                else if (instr_i[11:10] == 2'b00)
                    instr_o = {7'b0000000, instr_i[6:2], 2'b01, instr_i[9:7], 3'b101, 2'b01, instr_i[9:7], 7'b0010011};
                    // c.srai 
                else
                    instr_o = {7'b0100000, instr_i[6:2], 2'b01, instr_i[9:7], 3'b101, 2'b01, instr_i[9:7], 7'b0010011};
            end
            // c.j 
            5'b10101: instr_o = {instr_i[12], instr_i[8], instr_i[10:9], instr_i[6], instr_i[7], instr_i[2], instr_i[11], instr_i[5:3], instr_i[12], {8{instr_i[12]}}, 5'd0, 7'b1101111};
            // c.beqz 
            5'b11001: instr_o = {{4{instr_i[12]}}, instr_i[6], instr_i[5], instr_i[2], 5'd0, 2'b01, instr_i[9:7], 3'b000, instr_i[11], instr_i[10], instr_i[4], instr_i[3], instr_i[12], 7'b1100011};
            // c.bnez 
            5'b11101: instr_o = {{4{instr_i[12]}}, instr_i[6], instr_i[5], instr_i[2], 5'd0, 2'b01, instr_i[9:7], 3'b001, instr_i[11], instr_i[10], instr_i[4], instr_i[3], instr_i[12], 7'b1100011};
            // c.slli 
            5'b00010: instr_o = {7'b0000000, instr_i[6:2], instr_i[11:7], 3'b001, instr_i[11:7], 7'b0010011};
            // c.lwsp 
            5'b01010: instr_o = {4'b0000, instr_i[3:2], instr_i[12], instr_i[6:4], 2'b0, 5'd2, 3'b010, instr_i[11:7], 7'b0000011};
            // c.swsp 
            5'b11010: instr_o = {4'b0000, instr_i[8:7], instr_i[12], instr_i[6:2], 5'd2, 3'b010, instr_i[11:9], 2'b00, 7'b0100011};
            5'b10010: begin
                if (instr_i[6:2] == 5'd0) begin
                    // c.jalr 
                    if (instr_i[12] && instr_i[11:7] != 5'b0)
                        instr_o = {12'b0, instr_i[11:7], 3'b000, 5'd1, 7'b1100111};
                        // c.jr 
                    else instr_o = {12'b0, instr_i[11:7], 3'b000, 5'd0, 7'b1100111};
                end 
                else if (instr_i[11:7] != 5'b0) begin
                    // c.mv 
                    if (instr_i[12] == 1'b0)
                        instr_o = {7'b0000000, instr_i[6:2], 5'd0, 3'b000, instr_i[11:7], 7'b0110011};
                        // c.add 
                    else instr_o = {7'b0000000, instr_i[6:2], instr_i[11:7], 3'b000, instr_i[11:7], 7'b0110011};
                end
            end
            default : instr_o = 32'b0;
        endcase
    end

endmodule