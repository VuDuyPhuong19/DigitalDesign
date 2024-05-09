# Đầu vào: số nhị phân 8-bit trong thanh ghi a0
# Đầu ra: mã BCD trong thanh ghi a0

# binary_to_bcd:
#     div a1, a1, a2
#     li t0, 10            # Lưu giá trị 10 vào thanh ghi t0
#     li t1, 0             # Khởi tạo giá trị 0 cho thanh ghi t1

#     andi t2, t0, 0x0F    # Lấy 4 bit hàng đơn vị từ số nhị phân và lưu vào thanh ghi t2
#     andi t3, t0, 0xF0    # Lấy 4 bit hàng chục từ số nhị phân và lưu vào thanh ghi t3
#     srli t3, t3, 4        # Dịch phải 4 bit để đưa 4 bit hàng chục vào vị trí đúng trong thanh ghi t3

# loop:
#     add t1, t1, t2       # Cộng giá trị hàng đơn vị vào thanh ghi t1
#     addi t2, t2, -10     # Trừ 10 từ giá trị hàng đơn vị trong thanh ghi t2
#     bgez t2, loop        # Lặp lại quá trình cộng và trừ 10 cho đến khi giá trị hàng đơn vị là không âm

#     slli t1, t1, 4        # Dịch trái 4 bit để đưa giá trị hàng đơn vị vào vị trí đúng trong thanh ghi t1
#     or t1, t1, t3        # Kết hợp giá trị hàng chục từ thanh ghi t3 với giá trị hàng đơn vị trong thanh ghi t1

#     mv a0, t1            # Lưu giá trị mã BCD vào thanh ghi a0

#     ret

    li t0, 10          # Lưu giá trị 10 vào thanh ghi t0

    li t1, 59          # Sao chép giá trị đầu vào vào thanh ghi t1

    divu a1, t1, t0        # Chia số trong thanh ghi t1 cho 10 để lấy hàng chục
    remu a2, t1, t0    # Lưu phần dư vào thanh ghi a0
    ecall
