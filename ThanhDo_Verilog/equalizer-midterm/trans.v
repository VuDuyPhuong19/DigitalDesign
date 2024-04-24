# Định nghĩa hàm chuyển đổi từ số thực sang số học cố định
def to_fixed_point(real_number, bits_integer=1, bits_fractional=15):
    scale = 2 ** bits_fractional
    max_value = 2 ** (bits_integer + bits_fractional - 1) - 1
    min_value = -max_value - 1
    fixed_point_number = int(round(real_number * scale))
    if fixed_point_number > max_value or fixed_point_number < min_value:
        raise ValueError("Giá trị nằm ngoài phạm vi biểu diễn.")
    return fixed_point_number

# Hệ số bộ lọc thực tế
real_b0 = 0.0078125  # Ví dụ hệ số b0
real_b1 = -0.015625  # Ví dụ hệ số b1
real_a1 = 1.984375   # Ví dụ hệ số a1
real_a2 = -0.984375  # Ví dụ hệ số a2

# Chuyển đổi sang số học cố định
fixed_b0 = to_fixed_point(real_b0)
fixed_b1 = to_fixed_point(real_b1)
fixed_a1 = to_fixed_point(real_a1)
fixed_a2 = to_fixed_point(real_a2)

# In ra hệ số đã chuyển đổi
print(f"fixed_b0 = 16'd{fixed_b0};")
print(f"fixed_b1 = 16'd{fixed_b1};")
print(f"fixed_a1 = 16'd{fixed_a1};")
print(f"fixed_a2 = 16'd{fixed_a2};")
