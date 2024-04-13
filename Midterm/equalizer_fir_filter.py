import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import read as read_wav, write as write_wav
from scipy.signal import firwin, lfilter, freqz

# Đọc file âm thanh
sample_rate, data = read_wav('noisy_signal.wav')

# Kiểm tra tần số lấy mẫu
if sample_rate != 16000:
    raise ValueError("Sample rate of the file is not 16kHz.")

# Thiết kế bộ lọc FIR 8 băng tần sử dụng cửa sổ Hamming
bands = [(20, 170), (170, 310), (310, 600), (600, 1000), (1000, 3000), (3000, 6000), (6000, 7000), (7000, 7900)]
gains = [2, 0, 0, 0, 0, 0, 0, 0]
numtaps = 64  # Số hệ số của bộ lọc (order + 1)

equalized_signal = np.zeros(len(data))

# Khởi tạo một cửa sổ hình ảnh với 3 subplots
fig, axs = plt.subplots(3, 1, figsize=(15, 15))

# Áp dụng bộ lọc và cộng dồn kết quả
for (lowcut, highcut), gain in zip(bands, gains):
    # Tạo bộ lọc FIR sử dụng cửa sổ Hamming
    fir_coeff = firwin(numtaps, [lowcut, highcut], pass_zero=False, fs=sample_rate, window='hamming')
    filtered_signal = lfilter(fir_coeff, 1.0, data) * gain
    equalized_signal += filtered_signal
    
    # # In ra hệ số của mỗi băng tần
    # print(f"He so bo loc cho bang tan {lowcut}-{highcut} Hz: {fir_coeff}\n")

    
    # Đáp ứng tần số của bộ lọc
    w, h = freqz(fir_coeff, worN=8000, fs=sample_rate)
    axs[0].plot(w, 20 * np.log10(abs(h) * gain), label=f'{lowcut}-{highcut} Hz')  # Nhân h với gain trước khi vẽ
axs[0].set_xlabel('Frequency (Hz)')
axs[0].set_ylabel('Amplitude (dB)')
axs[0].set_title('Frequency Response of Each Filter')
axs[0].legend()
axs[0].grid(True)

# Lưu tín hiệu đã xử lý
write_wav('equalized_audio.wav', sample_rate, equalized_signal.astype(np.int16))

# Phổ thời gian
axs[1].plot(data[:1000], label='Original')
axs[1].plot(equalized_signal[:1000], label='Equalized', alpha=0.75)
axs[1].legend()
axs[1].set_xlabel('Sample')
axs[1].set_ylabel('Amplitude')
axs[1].set_title('Time Domain Signal')
axs[1].grid(True)

# Phổ tần số
fft_original = np.fft.fft(data)
fft_equalized = np.fft.fft(equalized_signal)
freqs = np.fft.fftfreq(len(fft_original), 1 / sample_rate)

axs[2].plot(freqs[:len(freqs) // 2], np.abs(fft_original)[:len(freqs) // 2], label='Original')
axs[2].plot(freqs[:len(freqs) // 2], np.abs(fft_equalized)[:len(freqs) // 2], label='Equalized', alpha=0.75)
axs[2].legend()
axs[2].set_xlabel('Frequency (Hz)')
axs[2].set_ylabel('Magnitude')
axs[2].set_title('Frequency Spectrum')
axs[2].grid(True)

# Hiển thị cửa sổ hình ảnh chứa tất cả các biểu đồ
plt.tight_layout()
plt.show()
