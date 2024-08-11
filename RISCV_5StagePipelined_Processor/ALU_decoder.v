module ALU_decoder#(
    parameter ADD_ALU = 4'b0000,
    parameter SUB_ALU = 4'b0001,
    parameter AND_ALU = 4'b0010,
    parameter OR_ALU = 4'b0011,
    parameter XOR_ALU = 4'b0100,
    parameter SLT_ALU = 4'b0101,
    parameter SHL_ALU = 4'b0110,
    parameter SHR_ALU = 4'b0111,
    parameter SGTe_ALU = 4'b1000,
    parameter EQUAL_ALU = 4'b1001,
    parameter NOT_EQUAL_ALU = 4'b1010,
    parameter ALUCONTROL_WIDTH = 4,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter ALU_OP_WIDTH = 2
)
(
    input [ALU_OP_WIDTH-1:0] ALUOp,
    input [FUNCT3_WIDTH-1:0] funct3,
    input [FUNCT7_WIDTH-1:0] funct7,
    output reg [ALUCONTROL_WIDTH-1:0] ALUControl
);

wire [FUNCT3_WIDTH+FUNCT7_WIDTH-1:0] get_fun;
assign get_fun = {funct3, funct7};

always@(*) begin // sai ở chỗ alway @ (get_fun)
//-----------------------------------R-Type-----------------------------------//
    if(ALUOp == 2'b10) begin
        case(get_fun)  
            // add
            10'b0000000000: begin 
                ALUControl = ADD_ALU;
            end
            // sub
            10'b0000100000: begin 
                ALUControl = SUB_ALU;
            end
            // xor
            10'b1000000000: begin 
                ALUControl = XOR_ALU; 
            end
            // or
            10'b1100000000: begin
                ALUControl = OR_ALU;
            end
            // and
            10'b1110000000: begin 
                ALUControl = AND_ALU;
            end
            // shift_left
            10'b0010000000: begin 
                ALUControl = SHL_ALU;
            end
            // shift_right
            10'b1010100000: begin 
                ALUControl = SHR_ALU;
            end
            // less_than
            10'b0100000000: 
                ALUControl = SLT_ALU;
        endcase
    end

//-----------------------------------I-Type-----------------------------------//
    
    else if(ALUOp == 2'b01) begin
            case(funct3)
            // add
            3'b000: begin 
                ALUControl = ADD_ALU;
            end
            // xor
            3'b100: begin 
                ALUControl = XOR_ALU;
            end
            // or
            3'b110: begin 
                ALUControl = OR_ALU;
            end
            // and
            3'b111: begin 
                ALUControl = AND_ALU;
            end
            // shift_left
            3'b001: begin 
                ALUControl = SHL_ALU;
            end
            // shift_right
            3'b101: begin 
                ALUControl = SHR_ALU;
            end
            // less_than
            3'b010: begin 
                ALUControl = SLT_ALU;
            end
            endcase
    end

//-------------------------------S-Type | L-Type------------------------------//

    else if(ALUOp == 2'b00) begin
        ALUControl = ADD_ALU;
    end

//-----------------------------------B-Type-----------------------------------//

    else begin
        case(funct3)
            3'b000: begin
                ALUControl = SUB_ALU;
            end
            3'b001: begin
                ALUControl = NOT_EQUAL_ALU;
            end
            3'b100: begin
                ALUControl = SLT_ALU;
            end
            3'b101: begin
                ALUControl = SGTe_ALU;
            end
        endcase
    end
end
endmodule