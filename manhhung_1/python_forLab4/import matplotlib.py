import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import read as read_wav, write as write_wav
from scipy.signal import lfilter, firwin

def plot_spectrum(audio_signal, sample_rate, title='Frequency Spectrum'):
    n = len(audio_signal)
    audio_fft = np.fft.fft(audio_signal)
    audio_freq = np.fft.fftfreq(n, d=1/sample_rate)
    n_half = n // 2
    audio_fft_half = audio_fft[:n_half]
    audio_freq_half = audio_freq[:n_half]

    plt.figure(figsize=(10, 6))
    plt.plot(audio_freq_half, np.abs(audio_fft_half))
    plt.title(title)
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Amplitude')
    plt.grid(True)

# Đọc file WAV
sample_rate, audio_data = read_wav('your_audio_file.wav')

# Kiểm tra tần số lấy mẫu
if sample_rate != 1000:
    print(f"Warning: The sample rate of the provided file is {sample_rate}Hz, not 1kHz.")

# Thiết kế bộ lọc FIR
numtaps = 15
cutoff = 0.2  # Tần số cắt so với tần số Nyquist
coeffs = firwin(numtaps, cutoff) #đây là lọc low pass nhé mấy bồ


# Áp dụng bộ lọc FIR
filtered_audio = lfilter(coeffs, 1.0, audio_data)

# Vẽ phổ tần số của tín hiệu gốc và đã lọc
plot_spectrum(audio_data, sample_rate, title='Original Audio Spectrum')
plot_spectrum(filtered_audio, sample_rate, title='Filtered Audio Spectrum')

plt.show()
