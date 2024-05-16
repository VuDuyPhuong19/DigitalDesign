.equ HOUR_TEN, 0 # equal - hằng số- ( emun in C)
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

.data           # value, meaning_of_number
second: .byte 0
clear_screen: .asciiz "                                                                                          \n"  # Chuỗi xóa màn hình và đưa con trỏ về đầu
message: .asciiz "\r\r\r\r"  # Chuỗi "abc" kết thúc bằng null
haicham: .asciiz " : "  # Chuỗi "abc" kết thúc bằng null

minute: .byte 0
minute_increment_flag: .byte 0
year_ten_s:     .byte 0, 0 
year_one_s:     .byte 0, 0
month_ten_s:    .byte 0, 0
month_one_s:    .byte 0, 0  
date_ten_s:     .byte 0, 0 
date_one_s:     .byte 0, 0  
hours_ten_s:    .byte 0, 0
hours_one_s:    .byte 0, 0 
minutes_ten_s:  .byte 0, 0
minutes_one_s:  .byte 0, 0
seconds_ten_s:  .byte 0, 0   
seconds_one_s:  .byte 0, 0    

.text
.globl main

main:
   

    li a1, 50           # Load giá trị 50 vào thanh ghi a1
    la a2, second      # Load địa chỉ của biến 'second' vào thanh ghi a2
    sw a1, 0(a2)       # Store giá trị từ a1 vào địa chỉ mà a2 trỏ đến (biến 'second')

    li a1, 58           # Load giá trị 50 vào thanh ghi a1
    la s4, minute      # Load địa chỉ của biến 'second' vào thanh ghi a2
    sw a1, 0(s4)       # Store giá trị từ a1 vào địa chỉ mà a2 trỏ đến (biến 'second')

loop:

    jal count_second
    #jal count_minute
    # jal update_led_matrix

    # minute
    mv a1, s4                   # Move the seconds value into a1 for printing
    li a0, 0x1                    # Set a0 to 1 for the print_int syscall
    ecall 

    la a1, haicham
    li a0, 0x04                   # Mã ecall cho in chuỗi
    ecall 

    # second
    mv a1, s3                   # Move the seconds value into a1 for printing
    li a0, 0x1                    # Set a0 to 1 for the print_int syscall
    ecall
     
    la a1, message
    li a0, 0x04                   # Mã ecall cho in chuỗi
    ecall
    la a1, message
    li a0, 0x04                   # Mã ecall cho in chuỗi
    ecall
    la a1, message
    li a0, 0x04                   # Mã ecall cho in chuỗi
    ecall     

   j loop

  
delay:
    li t0, 500  # Set the delay count; adjust this number based on your simulation speed
delay_loop:
    addi t0, t0, -1 # Decrement the counter
    bnez t0, delay_loop # Continue looping until the counter reaches zero
    ret
count_second:
    la s3, second               # Lấy địa chỉ của biến 'second' lưu vào s2
    lw s3, 0(s3)                # Tải giá trị giây hiện tại vào s2
    addi s3, s3, 1              # Tăng giá trị giây lên 1--- add immediate
    li t3, 60
    blt s3, t3, update_second   # bracnh if s2<t3

    li s3, 0                    # Reset giây về 0 khi đạt đến 60
    la t1, second
    sw s3, 0(t1)                # Lưu giá trị reset vào biến 'second'
    jal count_minute
    

update_second:

    la t3, second
    sw s3, 0(t3)                # Store the new seconds value back into 'second'  
    
    la t4, minute
    lw s4, 0(t4)

    mv t6, ra
    jal delay                   # Call delay function
    mv ra,t6
    ret

count_minute:
    la s4, minute               # Lấy địa chỉ của biến 'seminutecond' lưu vào s3
    lw s4, 0(s4)                # Tải giá trị giây hiện tại vào s2
    addi s4, s4, 1              # Tăng giá trị giây lên 1--- add immediate
    li t4, 60
    blt s4, t4, update_minute   # bracnh if s2<t3
    li s4, 0                    # Reset giây về 0 khi đạt đến 60
    la t1, minute
    sw s4, 0(t1)                # Lưu giá trị reset vào biến 'second'

update_minute:
    la t4, minute
    sw s4, 0(t4)
    li t4 0x00000024
    mv ra,t4
    ret
