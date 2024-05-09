.equ HOUR_TEN, 0
.equ HOUR_ONE, 1
.equ MINUTE_TEN, 2
.equ MINUTE_ONE, 3
.equ SECOND_TEN, 4
.equ SECOND_ONE, 5
.equ DAY_TEN, 6
.equ DAY_ONE, 7
.equ MONTH_TEN, 8
.equ MONTH_ONE, 9
.equ YEAR_TEN, 10
.equ YEAR_ONE, 11

.data
rows:
.word 0x00000000 # Row 0
.word 0x00000001 # Row 1
.word 0x00000002 # Row 2
.word 0x00000003 # Row 3
.word 0x00000004 # Row 4
columns:
.word 0x00000000 # Column 0
.word 0x00010000 # Column 1
.word 0x00020000 # Column 2
num0:  
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num1:
# Row 0
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
num2:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num3:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num4:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
num5:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num6:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num7:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
num8:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
num9:
# Row 0
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 1
.word 0x00FF0000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 2
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 3
.word 0x00000000 # Pixel color
.word 0x00000000 # Pixel color
.word 0x00FF0000 # Pixel color
# Row 4
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
.word 0x00FF0000 # Pixel color
hour_ten:
.byte 0x04, 0x02
hour_one: 
.byte 0x08, 0x02
minute_ten:
.byte 0x0E, 0x02
minute_one:
.byte 0x12, 0x02
second_ten:
.byte 0x18, 0x02
second_one:
.byte 0x1C, 0x02

day_ten:
.byte 0x01, 0x0B
day_one:
.byte 0x05, 0x0B
month_ten:
.byte 0x0A, 0x0B
month_one:
.byte 0x0E, 0x0B
year_ten:
.byte 0x1B, 0x0B
year_one:
.byte 0x1F, 0x0B 

.text
.globl main

main:
loop:
    jal count_second
    li a0, 0x100
    # Hour
    li a3, 1    # Chọn số để hiển thị (ví dụ: 4)
    li s0, HOUR_TEN
    jal display_number
    li a3, 2  
    li s0, HOUR_ONE
    jal display_number
    # Minute
    li a3, 4  
    li s0, MINUTE_TEN
    jal display_number
    li a3, 5  
    li s0, MINUTE_ONE
    jal display_number
    # Second
    li a3, 5  
    li s0, SECOND_TEN
    jal display_number
    li a3, 6  
    li s0, SECOND_ONE
    jal display_number

    # Day
    li a3, 1    # Chọn số để hiển thị (ví dụ: 4)
    li s0, DAY_TEN
    jal display_number
    li a3, 9  
    li s0, DAY_ONE
    jal display_number
    # Month
    li a3, 1  
    li s0, MONTH_TEN
    jal display_number
    li a3, 0  
    li s0, MONTH_ONE
    jal display_number
    # Year
    li a3, 0  
    li s0, YEAR_TEN
    jal display_number
    li a3, 3 
    li s0, YEAR_ONE
    jal display_number

    j loop

    # # Kết thúc chương trình
    # li a0, 10
    # ecall

display_number:
    la a4, rows
    la a5, columns

    li t0, 0
    beq a3, t0, equal_0
    li t0, 1
    beq a3, t0, equal_1
    li t0, 2
    beq a3, t0, equal_2
    li t0, 3
    beq a3, t0, equal_3
    li t0, 4
    beq a3, t0, equal_4
    li t0, 5
    beq a3, t0, equal_5
    li t0, 6
    beq a3, t0, equal_6
    li t0, 7
    beq a3, t0, equal_7
    li t0, 8
    beq a3, t0, equal_8
    li t0, 9
    beq a3, t0, equal_9

equal_0: 
    la a6, num0
    j next_1
equal_1: 
    la a6, num1   
    j next_1
equal_2: 
    la a6, num2
    j next_1
equal_3: 
    la a6, num3
    j next_1
equal_4: 
    la a6, num4
    j next_1
equal_5: 
    la a6, num5
    j next_1
equal_6: 
    la a6, num6
    j next_1
equal_7: 
    la a6, num7
    j next_1
equal_8: 
    la a6, num8
    j next_1
equal_9: 
    la a6, num9
    j next_1

next_1:
    li t0, HOUR_TEN
    beq s0, t0, is_hour_ten
    li t0, HOUR_ONE
    beq s0, t0, is_hour_one
    li t0, MINUTE_TEN
    beq s0, t0, is_minute_ten
    li t0, MINUTE_ONE
    beq s0, t0, is_minute_one
    li t0, SECOND_TEN
    beq s0, t0, is_second_ten
    li t0, SECOND_ONE
    beq s0, t0, is_second_one
    li t0, DAY_TEN
    beq s0, t0, is_day_ten
    li t0, DAY_ONE
    beq s0, t0, is_day_one
    li t0, MONTH_TEN
    beq s0, t0, is_month_ten
    li t0, MONTH_ONE
    beq s0, t0, is_month_one
    li t0, YEAR_TEN
    beq s0, t0, is_year_ten
    li t0, YEAR_ONE
    beq s0, t0, is_year_one

is_hour_ten:
    la a7, hour_ten
    j next_2
is_hour_one:
    la a7, hour_one
    j next_2
is_minute_ten:
    la a7, minute_ten
    j next_2
is_minute_one:
    la a7, minute_one
    j next_2
is_second_ten:
    la a7, second_ten
    j next_2
is_second_one:
    la a7, second_one
    j next_2
is_day_ten:
    la a7, day_ten
    j next_2
is_day_one:
    la a7, day_one
    j next_2
is_month_ten:
    la a7, month_ten
    j next_2
is_month_one:
    la a7, month_one
    j next_2
is_year_ten:
    la a7, year_ten
    j next_2
is_year_one:
    la a7, year_one
    j next_2

next_2:
    li t0, 0 # index i (Row)
    li t1, 0 # index j (Column)
    li t2, 0 # count 

loop_i: 
    slli s0, t0, 2  # s0 = t0 * 4 (since each .word is 4 bytes)
    add s0, a4, s0  # s0 = base address of rows + (i * 4)
    lw a1, 0(s0)    # Load the word at address s0 into a1
loop_j:
    slli s0, t1, 2 # s0 = t0 * 4 (since each .word is 4 bytes)
    add s0, a5, s0 # s0 = base address of columns + (i * 4)
    lw a2, 0(s0)

    lb s0, 0(a7) # y_offset
    lb s1, 1(a7) # x_offset
    slli s0, s0, 16
    add a2, a2, s0
    add a2, a2, s1

    mv s3, a1
    add a1, a2, a1 # pixel coordinates

    slli s0, t2, 2 # s0 = t2 * 4 (since each .word is 4 bytes)
    add s0, a6, s0 # s0 = base address of nums + (count * 4)
    lw a2, 0(s0) # Pixel values
    addi t2, t2, 1 # count++

    ecall
    li a1, 0x000C0003
    li a2, 0xF0F0F0 
    ecall
    li a1, 0x000C0005
    li a2, 0xF0F0F0 
    ecall
    li a1, 0x00160003
    li a2, 0xF0F0F0 
    ecall
    li a1, 0x00160005
    li a2, 0xF0F0F0 
    ecall
    mv a1, s3

    addi t1, t1, 1 # j++
    li t3, 3 # 3 columns
    blt t1, t3, loop_j

    li t1, 0
    addi t0, t0, 1 # i++
    li t3, 4 # 5 rows
    ble t0, t3, loop_i

    ret # return

count_second:
    li a1, 0
    addi a1, a1, 1
    li a2, 60
    beq a1, a2, reset_second
    mv a0, a1
    ret # return

reset_second:
    li a1, 0
    mv a0, a1 # Output
    ret #return 

