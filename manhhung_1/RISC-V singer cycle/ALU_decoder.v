module ALU_decoder#(
    parameter ADD_ALU = 3'b 000,
    parameter SUB_ALU = 3'b 001,
    parameter AND_ALU = 3'b 010,
    parameter OR_ALU = 3'b 011,
    parameter XOR_ALU= 3'b 100,
    parameter SLT_ALU= 3'b 101,
    parameter SHL_ALU= 3'b 110,
    parameter SHR_ALU= 3'b 111
)
(
	input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [2:0] ALUControl
);
//.....................................R-type...............................
wire [9:0] get_fun;
assign get_fun=funct3<<7+funct7;
always@(get_fun) begin
    if(ALUOp==2'b 10) begin
        case(get_fun)  
            10'b 0000000000: begin //add
                ALUControl= ADD_ALU;
            end
            10'b 0000100000: begin //sub
                ALUControl=SUB_ALU;
            end
            10'b 1000000000: begin //xor
                ALUControl=XOR_ALU; 
            end
            10'b 1100000000:begin//or
                ALUControl=OR_ALU;
            end
            10'b 1110000000: begin //and
                ALUControl=AND_ALU;
            end
            10'b 1010000000: begin //shift_left
                ALUControl=SHL_ALU;
            end
            10'b 1010100000: begin //shift_right
                ALUControl=SHR_ALU;
            end
            10'b 0100000000: //less_than
                ALUControl=SLT_ALU;
     /*  10'b 0110000000: */
        endcase
    end
    else begin
    //.....................................I-type...............................
        if(ALUOp==2'b01) begin
            case(funct3)
            3'b 000: begin //add
                ALUControl=ADD_ALU;
            end
            3'b 100: begin //xor
                ALUControl=XOR_ALU;
            end
            3'b 110: begin //or
                ALUControl=OR_ALU;
            end
            3'b 111: begin //and
                ALUControl=AND_ALU;
            end
            3'b 001: begin //shift_left
                ALUControl=SHL_ALU;
            end
            3'b 101:begin //shift_right
                ALUControl=SHR_ALU;
            end
            3'b 010:begin //less_than
                ALUControl=SLT_ALU;
            end
            3'b 011:begin
                ALUControl=SLT_ALU;
            end
            endcase
        end
        else begin
            if(ALUOp==2'b00) begin
                ALUControl=3'b 000;
            end
            else begin
                ALUControl=3'b 101;
            end
        end
    end
end
endmodule