
def to_fixed_point(real_number, bits_integer=2, bits_fractional=14):
    scale = 2 ** bits_fractional
    max_value = 2 ** (bits_integer + bits_fractional - 1) - 1
    min_value = -(2 ** (bits_integer + bits_fractional - 1))  # Giá trị tối thiểu cho số âm
    fixed_point_number = int(round(real_number * scale))
    if fixed_point_number > max_value or fixed_point_number < min_value:
        raise ValueError(f"Giá trị {real_number} nằm ngoài phạm vi biểu diễn của Q{bits_integer}.{bits_fractional}.")
    return fixed_point_number
# Hệ số bộ lọc thực tế
real_b0 =0.01856301  # Ví dụ hệ số b0
real_b1 =  0.07425204 # Ví dụ hệ số b1
real_b2 = 0.11137806 # Ví dụ hệ số b1
real_b3 =  0.07425204  # Ví dụ hệ số b1
real_b4 = 0.01856301 # Ví dụ hệ số b1
real_a1 = -1.57039885   # Ví dụ hệ số a1
real_a2 =   1.27561332  # Ví dụ hệ số a2
real_a3 = -0.48440337   # Ví dụ hệ số a1
real_a4 =   0.07619706  # Ví dụ hệ số a2

# Chuyển đổi sang số học cố định với Q2.14
fixed_b0 = to_fixed_point(real_b0, 2, 28)
fixed_b1 = to_fixed_point(real_b1, 2, 28)
fixed_b2 = to_fixed_point(real_b2, 2, 28)
fixed_b3 = to_fixed_point(real_b3, 2, 28)
fixed_b4 = to_fixed_point(real_b4, 2, 28)
fixed_a1 = to_fixed_point(real_a1, 2, 28)
fixed_a2 = to_fixed_point(real_a2, 2, 28)
fixed_a3 = to_fixed_point(real_a3, 2, 28)
fixed_a4 = to_fixed_point(real_a4, 2, 28)


# In ra hệ số đã chuyển đổi
print(f"fixed_b0 = {fixed_b0};")  # Sử dụng dạng giá trị số học cố định để hiển thị số âm
print(f"fixed_b1 = {fixed_b1};")
print(f"fixed_b1 = {fixed_b2};")
print(f"fixed_b1 = {fixed_b3};")
print(f"fixed_b1 = {fixed_b4};")
print(f"fixed_a1 = {fixed_a1};")
print(f"fixed_a2 = {fixed_a2};")
print(f"fixed_a1 = {fixed_a3};")
print(f"fixed_a2 = {fixed_a4};")
