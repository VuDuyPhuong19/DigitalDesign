# addi x3, x0, -15
# addi x4, x0, 3
# mul x5, x3, x4
# mulh x6, x3, x4
# mulhu x7, x3, x4
# mulhsu x8, x3, x4

# addi x6, x0, 10

    # addi x3, x0, -7   # x3 = -15
    # addi x4, x0, -8     # x4 = 3

    # mul x5, x3, x4      # x5 = x3 * x4 (result = -45)
    # mulh x6, x3, x4     # x6 = (high bits of x3 * x4)
    # mulhu x7, x3, x4    # x7 = (unsigned high bits of x3 * x4)
    # mulhsu x8, x3, x4   # x8 = (high bits of x3 signed, x4 unsigned)

    addi x3, x0, -17   # x3 = -15
    addi x4, x0, 5     # x4 = 3

    div x5, x3, x4      # x5 = x3 * x4 (result = -45)
    divu x6, x3, x4     # x6 = (high bits of x3 * x4)
    rem x7, x3, x4    # x7 = (unsigned high bits of x3 * x4)
    remu x8, x3, x4   # x8 = (high bits of x3 signed, x4 unsigned)

    # Store results in memory for comparison
    la x10, result_memory
    sw x5, 0(x10)
    sw x6, 4(x10)
    sw x7, 8(x10)
    sw x8, 12(x10)

    # Add a simple end condition (infinite loop)
    addi x6, x0, 10

.data
result_memory:
    .word 0x00000000  # Placeholders for results
    .word 0x00000000
    .word 0x00000000
    .word 0x00000000
