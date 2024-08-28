module ALU_decoder #(
    parameter ALUCONTROL_WIDTH = 6,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter ALU_OP_WIDTH = 2,
    parameter OPCODE_WIDTH = 7,
    parameter ADD_ALU = 6'b000000,
    parameter SUB_ALU = 6'b000001,
    parameter AND_ALU = 6'b000010,
    parameter OR_ALU = 6'b000011,
    parameter XOR_ALU = 6'b000100,
    parameter SLT_ALU = 6'b000101,
    parameter SLL_ALU = 6'b000110,
    parameter SRA_ALU = 6'b000111,
    parameter SGTe_ALU = 6'b001000,
    parameter EQUAL_ALU = 6'b001001,
    parameter NOT_EQUAL_ALU = 6'b001010,
    parameter SRL_ALU = 6'b001011,      // srl
    parameter SLTU_ALU = 6'b001100,     //sltu
    parameter SGTeU_ALU = 6'b001101,    // bgeu
    parameter JALR_ALU = 6'b001110,     // jalr
    parameter SHADD_ALU = 6'b001111,    // sh1add, sh2add, sh3add
    parameter ANDN_ALU = 6'b010000,     // andn
    parameter ORN_ALU = 6'b010001,      // orn
    parameter XNOR_ALU = 6'b010010,     // xnor
    parameter MAX_ALU = 6'b010011,      // max, maxu
    parameter MIN_ALU = 6'b010100,      // min, minu
    parameter SEXT_ALU = 6'b010101,     // sext.b, sext.h
    parameter ZEXT_ALU = 6'b010110,     // zext.h  
    parameter ROL_ALU   = 6'b010111,    // rol
    parameter ROR_ALU   = 6'b011000,    // ror / rori
    parameter BCLR_ALU  = 6'b011001,    // bclr 
    parameter BCLRI_ALU = 6'b011010,    // bclri
    parameter BEXT_ALU  = 6'b011011,    // bext
    parameter BEXTI_ALU = 6'b011100,    // bexti
    parameter BINV_ALU  = 6'b011101,    // binv
    parameter BINVI_ALU = 6'b011110,    // binvi
    parameter BSET_ALU  = 6'b011111,    // bset
    parameter BSETI_ALU = 6'b100000,    // bseti
)
(
    input [OPCODE_WIDTH-1:0] opcode,
    input [ALU_OP_WIDTH-1:0] ALUOp,
    input [FUNCT3_WIDTH-1:0] funct3,
    input [FUNCT7_WIDTH-1:0] funct7,
    output reg [ALUCONTROL_WIDTH-1:0] ALUControl
);

wire [FUNCT3_WIDTH+FUNCT7_WIDTH-1:0] get_fun;
assign get_fun = {funct3, funct7};

always @ (*) begin
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
            // shift_left (sll)
            10'b0010000000: begin 
                ALUControl = SLL_ALU;
            end
            // shift_right (sra)
            10'b1010100000: begin 
                ALUControl = SRA_ALU;
            end
            // shift_right (srl)
            10'b1010000000: begin 
                ALUControl = SRL_ALU;
            end
            // set less than (slt)
            10'b0100000000: begin
                ALUControl = SLT_ALU;
            end
            // set less than unsigned (sltu)
            10'b0110000000: begin
                ALUControl = SLTU_ALU;
            end
            // shadd
            10'b0100010000, 10'b1000010000, 10'b1100010000: begin
                ALUControl = SHADD_ALU;
            end 
            // andn
            10'b1110100000: begin
                ALUControl = ANDN_ALU;
            end 
            // orn 
            10'b1100100000 : begin
                ALUControl = ORN_ALU;
            end 
            // xnor 
            10'b1000100000 : begin
                ALUControl = XNOR_ALU;
            end
            // max
            10'b1100000101, 10'b1110000101: begin
                ALUControl = MAX_ALU;
            end
            // min 
            10'b1000000101, 10'b1010000101: begin
                ALUControl = MIN_ALU;
            end
            // zext.h
            10'b1000000100: begin
                ALUControl = ZEXT_ALU;
            end
            // rol
            10'b0010110000: begin
                ALUControl = ROL_ALU;
            end
            // ror / rori
            10'b1010110000: begin
                ALUControl = ROR_ALU;
            end
            // bclr
            10'b0010100100: begin
                ALUControl = BCLR_ALU;
            end
            // bext
            10'b1010100100: begin
                ALUControl = BEXT_ALU;
            end 
            // binv 
            10'b0010110100: begin
                ALUControl = BINV_ALU;
            end 
            // bset 
            10'b0010010100: begin
                ALUControl = BSET_ALU;
            end

            default: begin
                ALUControl = ADD_ALU; 
            end
        endcase
    end

//-----------------------------------I-Type-----------------------------------//
    
    else if(ALUOp == 2'b01) begin
        case(funct3)
        3'b000: begin 
            if (opcode == 7'b1100111) begin 
                ALUControl = JALR_ALU;      // jalr
            end
            else begin
               ALUControl = ADD_ALU;        // addi
            end
            
        end
        // xori
        3'b100: begin 
            ALUControl = XOR_ALU;
        end
        // ori
        3'b110: begin 
            ALUControl = OR_ALU;
        end
        // andi
        3'b111: begin 
            ALUControl = AND_ALU;
        end
        
        3'b001: begin 
            // ALUControl = SLL_ALU;
            if (funct7 == 7'b0110000) begin
                ALUControl = SEXT_ALU; // sext.b / sext.h
            end
            else if (funct7 == 7'b0100100) begin // bclri
                ALUControl = BCLRI_ALU;
            end
            else if (funct7 == 7'b0110100) begin // binvi
                ALUControl = BINVI_ALU;
            end
            else if (funct7 == 7'b0010100) begin
                ALUControl = BSETI_ALU;
            end
            else begin
                ALUControl = SLL_ALU; // slli
            end
        end
        3'b101: begin 
            if (funct7 == 7'b0100000) begin // srai
                ALUControl = SRA_ALU;
            end
            else if (funct7 == 7'b0110000) begin // rori
                ALUControl = ROR_ALU;
            end
            else if (funct7 == 7'b0100100) begin // bexti
                ALUControl = BEXTI_ALU;
            end
            else begin
               ALUControl = SRL_ALU;  // srli
            end
        end
        // slti
        3'b010: begin 
            ALUControl = SLT_ALU;
        end
        // sltiu
        3'b011: begin 
            ALUControl = SLTU_ALU;
        end

        default: begin 
            ALUControl = ADD_ALU;
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
            // beq
            3'b000: begin
                ALUControl = SUB_ALU;
            end
            // bne
            3'b001: begin
                ALUControl = NOT_EQUAL_ALU;
            end
            // blt
            3'b100: begin
                ALUControl = SLT_ALU;
            end
            // bltu
            3'b110: begin
                ALUControl = SLTU_ALU;
            end
            // bge
            3'b101: begin
                ALUControl = SGTe_ALU;
            end
            // bgeu
            3'b111: begin
                ALUControl = SGTeU_ALU;
            end
            default: begin 
                ALUControl = ADD_ALU;
            end
        endcase
    end
end
endmodule