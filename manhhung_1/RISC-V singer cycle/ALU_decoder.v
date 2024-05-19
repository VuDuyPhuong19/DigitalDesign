module ALU_decoder(
	input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [2:0] ALUControl
);
//.....................................R-type...............................
wire [9:0] get_fun;
assign get_fun=funct3<<7+funct7;
always@(get_fun) begin
    if(ALUOp==10) begin
        case(get_fun)  
            10'b 0000000000: begin //add
                ALUControl=000;
            end
            10'b 0000100000: begin //sub
                ALUControl=001;
            end
            10'b 1000000000: begin //xor
                ALUControl=100; //xor
            end
            10'b 1100000000:begin//or
                ALUControl=011;
            end
            10'b 1110000000: begin //and
                ALUControl=010;
            end
        /*  10'b 1010000000:
            10'b 1010100000:
            10'b 0100000000:
            10'b 0110000000: */
        endcase
    end
    else begin
    //.....................................I-type...............................
        if(ALUOp==01) begin
            case(funct3)
            3'b 000: begin
                ALUControl=000;
            end
            3'b 100: begin
                ALUControl=100;
            end
            3'b 110: begin
                ALUControl=011;
            end
            3'b 010: begin
                ALUControl=010;
            end
           /* 3'b 111:
            3'b 001:
            3'b 101:
            3'b 010:
            3'b 011: */
            endcase
        end
    end
end
endmodule