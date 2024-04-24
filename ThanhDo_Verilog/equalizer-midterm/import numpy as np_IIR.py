from scipy.io.wavfile import read as read_wav, write as write_wav
from scipy.signal import butter, lfilter, freqz
import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft

# Hàm lọc band-pass sử dụng hệ số a, b
def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(1, [low, high], btype='band', output='ba')
    b *= 1  # Tăng độ lợi của tử số
    return b, a

# Áp dụng bộ lọc IIR dạng a, b
def apply_filter(data, lowcut, highcut, fs, gain, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    filtered = lfilter(b, a, data)
    return filtered * gain

# Các bước đọc file và kiểm tra tần số lấy mẫu giống như trong đoạn mã ban đầu
sample_rate, data = read_wav('noisy_signal.wav')
if sample_rate != 16000:
    raise ValueError("Sample rate of the file is not 16kHz.")

bands = [(20, 170), (170, 310), (310, 600), (600, 1000), (1000, 3000), (3000, 6000)]
gains = [0,1, 1, 1, 0, 0]
equalized_signal = np.zeros(len(data))
fig, axs = plt.subplots(3, 1, figsize=(15, 15))

# Đáp ứng tần số cho mỗi bộ lọc
for (lowcut, highcut), gain in zip(bands, gains):
    b, a = butter_bandpass(lowcut, highcut, sample_rate, order=5)
    w, h = freqz(b, a, worN=2000)
    axs[0].plot((w/np.pi) * (sample_rate/2), abs(h) * gain, label=f'{lowcut}-{highcut} Hz')

axs[0].set_xlabel('Frequency (Hz)')
axs[0].set_ylabel('Gain')
axs[0].set_title('Frequency Response of Each Filter')
axs[0].legend()
axs[0].grid(True)

# Áp dụng bộ lọc và cộng dồn kết quả, cùng các bước hiển thị kết quả như trong mã gốc
for (lowcut, highcut), gain in zip(bands, gains):
    filtered_signal = apply_filter(data, lowcut, highcut, sample_rate, gain)
    equalized_signal += filtered_signal

write_wav('equalized_audio.wav', sample_rate, equalized_signal.astype(np.int16))

# Vẽ đồ thị thời gian và phổ tần số, như trong đoạn mã ban đầu
axs[1].plot(data[:1000], label='Original')
axs[1].plot(equalized_signal[:1000], label='Equalized', alpha=0.75)
axs[1].legend()
axs[1].set_xlabel('Sample')
axs[1].set_ylabel('Amplitude')
axs[1].set_title('Time Domain Signal')
axs[1].grid(True)

fft_original = fft(data)
fft_equalized = fft(equalized_signal)
freqs = np.fft.fftfreq(len(fft_original), 1/sample_rate)

axs[2].plot(freqs[:len(freqs)//2], np.abs(fft_original)[:len(freqs)//2], label='Original')
axs[2].plot(freqs[:len(freqs)//2], np.abs(fft_equalized)[:len(freqs)//2], label='Equalized', alpha=0.75)
axs[2].legend()
axs[2].set_xlabel('Frequency (Hz)')
axs[2].set_ylabel('Magnitude')
axs[2].set_title('Frequency Spectrum')
axs[2].grid(True)

plt.tight_layout()
plt.show()
print(a)
print(b)