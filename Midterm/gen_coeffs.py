import sys
from scipy.signal import butter

# Cấu hình stdout để sử dụng mã hóa UTF-8 trên Python 3.7 trở lên
sys.stdout.reconfigure(encoding='utf-8')

def design_filter(order, cutoff, fs, btype='low'):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    b, a = butter(order, normal_cutoff, btype=btype, analog=False)
    return b, a

# Thiết lập các thông số cho bộ lọc
order = 2 # Thứ tự của bộ lọc
fs = 16000  # Tần số lấy mẫu là 16 kHz
cutoff = fs / 4  # Tần số cắt là 1/4 tần số lấy mẫu

# Thiết kế bộ lọc và lấy các hệ số
b, a = design_filter(order, cutoff, fs, btype='low')

# In ra các hệ số
print("Coefficients of the numerator (b):", b)
print("Coefficients of the denominator (a):", a)