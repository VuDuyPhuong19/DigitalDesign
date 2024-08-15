module ALU_decoder#(
    parameter ADD_ALU = 4'b0000,
    parameter SUB_ALU = 4'b0001,
    parameter AND_ALU = 4'b0010,
    parameter OR_ALU = 4'b0011,
    parameter XOR_ALU = 4'b0100,
    parameter SLT_ALU = 4'b0101,
    parameter SLL_ALU = 4'b0110,
    parameter SRA_ALU = 4'b0111,
    parameter SGTe_ALU = 4'b1000,
    parameter EQUAL_ALU = 4'b1001,
    parameter NOT_EQUAL_ALU = 4'b1010,
    parameter SRL_ALU = 4'b1011, // srl
    parameter SLTU_ALU = 4'b1100, //sltu
    parameter SGTeU_ALU = 4'b1101, // bgeu
    parameter JALR_ALU = 4'b1110, // jalr
    parameter ALUCONTROL_WIDTH = 4,
    parameter FUNCT3_WIDTH = 3,
    parameter FUNCT7_WIDTH = 7,
    parameter ALU_OP_WIDTH = 2,
    parameter OPCODE_WIDTH = 7
)
(
    input  [OPCODE_WIDTH-1:0] opcode,
    input [ALU_OP_WIDTH-1:0] ALUOp,
    input [FUNCT3_WIDTH-1:0] funct3,
    input [FUNCT7_WIDTH-1:0] funct7,
    output reg [ALUCONTROL_WIDTH-1:0] ALUControl
);

wire [FUNCT3_WIDTH+FUNCT7_WIDTH-1:0] get_fun;
assign get_fun = {funct3, funct7};

always @ (*) begin // sai ở chỗ alway @ (get_fun)
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
            // slli
            3'b001: begin 
                ALUControl = SLL_ALU;
            end
            3'b101: begin 
                if (funct7 == 7'b0100000) begin // srai
                    ALUControl = SRA_ALU;
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