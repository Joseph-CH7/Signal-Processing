function [filtered_signal] = apply_lpf(signal, fs)
% apply_lpf - Applies low-pass FIR filter to input signal and plots responses
%
% Inputs:
%   signal - input signal vector
%   fs     - sampling frequency
%
% Output:
%   filtered_signal - filtered output signal

% Filter design
fc = 800;           % Cutoff frequency in Hz
N = 101;             % Filter order (odd number)
fc_norm = fc / (fs/2);  % Normalized cutoff (0 to 1)

n = 0:N-1;
alpha = (N-1)/2;

% Custom sinc function
x = fc_norm * (n - alpha);
h_ideal = fc_norm * ones(size(x));
nonzero_idx = x ~= 0;
h_ideal(nonzero_idx) = fc_norm * sin(pi * x(nonzero_idx)) ./ (pi * x(nonzero_idx));

% Custom Hamming window
w = 0.54 - 0.46 * cos(2 * pi * n / (N-1));

% Apply window
h = h_ideal .* w;

% Plot impulse response
figure;
stem(n - alpha, h);
xlabel('Samples');
ylabel('Amplitude');
title('Impulse Response of Low-pass FIR Filter');
grid on;

% Frequency response using ftr
T_h = (N-1)/fs;
t_h = (0:N-1)/fs;
[f_h, H_ftr, ~] = ftr(t_h, h, T_h);

figure;
plot(f_h, abs(H_ftr)/max(abs(H_ftr)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Response of Low-pass FIR Filter (using ftr)');
grid on;

% Notify user
disp('Filtering the signal... Please wait (this may take ~10 seconds)...');

% Filter the signal
filtered_signal = conv(signal, h, 'same');

end
