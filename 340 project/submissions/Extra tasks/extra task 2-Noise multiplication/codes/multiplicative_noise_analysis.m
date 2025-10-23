% Load or create a test signal
load('my_recording.mat');  % should contain variable 'y' and 'fs'

% Extract a clean 2-second segment
start_idx = round(2.5 * fs);
end_idx = round(4.5 * fs);
segment = y(start_idx:end_idx);
t = (0:length(segment)-1) / fs;

% Add multiplicative Gaussian noise
sigma = 0.2;  % noise strength
noise = sigma * randn(size(segment));
x_mult_noise = segment .* (1 + noise);  % Multiplicative noise

% Sampling
fs_sample = 1000;  % Sampling frequency
[t_sample, x_sample] = sample(t, x_mult_noise, fs_sample);

% Reconstruction
t_rec = t;
[~, x_rec] = reconstruct(t_sample, x_sample, t_rec);

% Plot 1: Original vs Multiplicatively Noisy
figure;
subplot(2,1,1);
plot(t, segment, 'b'); hold on;
plot(t, x_mult_noise, 'r');
legend('Original', 'Multiplicative Noise');
title('Original vs Multiplicatively Noisy Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Plot 2: Reconstructed Signal
subplot(2,1,2);
plot(t, segment, 'b'); hold on;
plot(t_rec, x_rec, 'g');
legend('Original', 'Reconstructed');
title('Reconstruction of Multiplicatively Noisy Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Plot 3: Error
figure;
error = abs(segment - x_rec);
plot(t, error, 'k');
title('Absolute Reconstruction Error');
xlabel('Time (s)'); ylabel('|Original - Reconstructed|');
grid on;
