import numpy as np

def read_coefficients(file_path):
    with open(file_path, 'r') as file:
        coefficients = [float(line.strip()) for line in file.readlines()]
    return coefficients

def convert_to_fixed_point(coefficients, fraction_bits=14):
    fixed_point_values = []
    for coeff in coefficients:
        # Scale the coefficient by 2^fraction_bits and convert to integer
        scaled_value = int(np.floor(coeff * (2 ** fraction_bits)))
        # Convert to 16-bit two's complement if needed
        if scaled_value < 0:
            fixed_point_value = (1 << 16) + scaled_value
        else:
            fixed_point_value = scaled_value
        # Convert to binary string with padding to 16 bits
        binary_string = format(fixed_point_value, '016b')
        fixed_point_values.append(binary_string)
    return fixed_point_values

def write_fixed_point_values(fixed_point_values, output_file_path):
    with open(output_file_path, 'w') as file:
        for value in fixed_point_values:
            # Write the binary string to the file
            file.write(f"{value}\n")

def main():
    coefficients = read_coefficients('coefficients.txt')
    fixed_point_values = convert_to_fixed_point(coefficients)
    write_fixed_point_values(fixed_point_values, 'output_fixed_point.txt')

if __name__ == "__main__":
    main()
