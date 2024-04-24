from scipy.signal import butter

def generate_iir_coefficients(fs, lowcut, highcut, filter_order):
    nyquist = 0.5 * fs
    low = lowcut / nyquist
    high = highcut / nyquist
    b, a = butter(filter_order, [low, high], btype='band', analog=False)
    return b, a

# Sampling rate and desired cutoff frequencies
fs = 16000  # Example: 16 kHz sampling rate
lowcut = 300  # Lower bound of the passband in Hz
highcut = 3400  # Upper bound of the passband in Hz

# Generate coefficients for a 4th order filter
# (4th order generates 5 feedforward and 4 feedback coefficients for bandpass)
filter_order = 4
b, a = generate_iir_coefficients(fs, lowcut, highcut, filter_order)

# Output the coefficients
print('Feedforward coefficients:', b)
print('Feedback coefficients:', a)
