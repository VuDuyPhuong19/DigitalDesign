import sys
import io

# Đặt encoding mặc định cho stdout và stderr là UTF-8
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Phần còn lại của code
import numpy as np
from scipy.signal import butter

def design_iir_filter(order=4, cutoff=0.1, filter_type='low', fs=1.0):
    nyquist = 0.5 * fs
    normal_cutoff = cutoff / nyquist
    b, a = butter(order, normal_cutoff, btype=filter_type, analog=False)
    return b, a

b, a = design_iir_filter(order=4, cutoff=0.3, filter_type='low', fs=2)

print("Hệ số forward (b):", b)
print("Hệ số feedback (a):", a)
