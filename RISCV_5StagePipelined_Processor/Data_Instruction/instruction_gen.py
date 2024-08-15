import re
import struct

# Dictionary for opcode, funct3, and funct7 values
opcode_map = {
    'R-type': '0110011',
    'I-type': '0010011',
    'S-type': '0100011',
    'SB-type': '1100011',
    'U-type': '0110111',
    'UJ-type': '1101111'
}

funct3_map = {
    'ADD': '000',
    'SUB': '000',
    'AND': '111',
    'OR': '110',
    'XOR': '100',
    'ADDI': '000',
    'SW': '010',
    'LW': '010',
    'BEQ': '000',
    'BLTU': '110'
}

funct7_map = {
    'ADD': '0000000',
    'SUB': '0100000',
    'AND': '0000000'
}

register_map = {
    'x0': '00000', 'x1': '00001', 'x2': '00010', 'x3': '00011', 'x4': '00100',
    'x5': '00101', 'x6': '00110', 'x7': '00111', 'x8': '01000', 'x9': '01001',
    'x10': '01010', 'x11': '01011', 'x12': '01100', 'x13': '01101', 'x14': '01110',
    'x15': '01111', 'x16': '10000', 'x17': '10001', 'x18': '10010', 'x19': '10011',
    'x20': '10100', 'x21': '10101', 'x22': '10110', 'x23': '10111', 'x24': '11000',
    'x25': '11001', 'x26': '11010', 'x27': '11011', 'x28': '11100', 'x29': '11101',
    'x30': '11110', 'x31': '11111'
}

def parse_assembly_line(line):
    parts = line.strip().split()
    instruction = parts[0]
    operands = parts[1].split(',') if len(parts) > 1 else []
    return instruction, operands

def encode_r_type(instruction, operands):
    funct7 = funct7_map[instruction.upper()]
    rs2 = register_map[operands[2].strip()]
    rs1 = register_map[operands[1].strip()]
    funct3 = funct3_map[instruction.upper()]
    rd = register_map[operands[0].strip()]
    opcode = opcode_map['R-type']
    return funct7 + rs2 + rs1 + funct3 + rd + opcode

def encode_i_type(instruction, operands):
    imm = format(int(operands[2]), '012b')
    rs1 = register_map[operands[1].strip()]
    funct3 = funct3_map[instruction.upper()]
    rd = register_map[operands[0].strip()]
    opcode = opcode_map['I-type']
    return imm + rs1 + funct3 + rd + opcode

def encode_s_type(instruction, operands):
    imm = format(int(re.search(r'\d+', operands[1]).group()), '012b')
    rs2 = register_map[operands[0].strip()]
    rs1 = register_map[re.search(r'x\d+', operands[1]).group()]
    funct3 = funct3_map[instruction.upper()]
    imm = imm[0:7] + rs2 + rs1 + funct3 + imm[7:12]
    opcode = opcode_map['S-type']
    return imm + opcode

def encode_sb_type(instruction, operands, label_addresses, current_address):
    imm = format(label_addresses[operands[2].strip()] - current_address, '013b')
    rs2 = register_map[operands[1].strip()]
    rs1 = register_map[operands[0].strip()]
    funct3 = funct3_map[instruction.upper()]
    imm = imm[0] + imm[2:8] + rs2 + rs1 + funct3 + imm[8:12] + imm[1]
    opcode = opcode_map['SB-type']
    return imm + opcode

def encode_u_type(instruction, operands):
    imm = format(int(operands[1]), '020b')
    rd = register_map[operands[0].strip()]
    opcode = opcode_map['U-type']
    return imm + rd + opcode

def encode_uj_type(instruction, operands, label_addresses, current_address):
    imm = format(label_addresses[operands[1].strip()] - current_address, '021b')
    rd = register_map[operands[0].strip()]
    imm = imm[0] + imm[10:20] + imm[9] + imm[1:9] + imm[20]
    opcode = opcode_map['UJ-type']
    return imm + rd + opcode

def assemble_instruction(instruction, operands, label_addresses, current_address):
    if instruction.upper() in funct7_map:
        return encode_r_type(instruction, operands)
    elif instruction.upper() in funct3_map:
        return encode_i_type(instruction, operands)
    elif instruction.upper() == 'SW' or instruction.upper() == 'LW':
        return encode_s_type(instruction, operands)
    elif instruction.upper() == 'BEQ' or instruction.upper() == 'BLTU':
        return encode_sb_type(instruction, operands, label_addresses, current_address)
    elif instruction.upper() == 'LUI':
        return encode_u_type(instruction, operands)
    elif instruction.upper() == 'JAL':
        return encode_uj_type(instruction, operands, label_addresses, current_address)
    else:
        raise ValueError(f"Unsupported instruction: {instruction}")

def main():
    input_file = 'simple.s'
    output_file = 'simple.bin'

    with open(input_file, 'r') as f:
        lines = f.readlines()

    binary_instructions = []
    label_addresses = {}
    current_address = 0

    # First pass: determine label addresses
    for line in lines:
        if ':' in line:
            label = line.split(':')[0].strip()
            label_addresses[label] = current_address
        else:
            current_address += 4

    current_address = 0

    # Second pass: encode instructions
    for line in lines:
        if ':' in line:
            continue
        instruction, operands = parse_assembly_line(line)
        binary_instruction = assemble_instruction(instruction, operands, label_addresses, current_address)
        binary_instructions.append(binary_instruction)
        current_address += 4

    with open(output_file, 'wb') as f:
        for binary_instruction in binary_instructions:
            instruction_bytes = int(binary_instruction, 2).to_bytes(4, byteorder='little')
            f.write(instruction_bytes)

if __name__ == "__main__":
    main()
