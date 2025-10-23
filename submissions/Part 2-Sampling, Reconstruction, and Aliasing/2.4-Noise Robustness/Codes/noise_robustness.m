% Original signal
t = linspace(0, 1, 1000);
xt = cos(2*pi*3*t) + 0.5*cos(2*pi*7*t);
f_max = 7;

t_rec = t;  % Reconstruction grid

% Under-sampling (fs = 10 Hz) ---
fs1 = 10;
[t_sample1, x_sample1] = sample(t, xt, fs1);
noise1 = 0.2 * randn(size(x_sample1));
x_sample1_noisy = x_sample1 + noise1;
[~, x_rec1] = reconstruct(t_sample1, x_sample1_noisy, t_rec);

figure;
plot(t, xt, 'b'); hold on;
stem(t_sample1, x_sample1_noisy, 'r', 'filled');
plot(t_rec, x_rec1, 'g--');
legend('Original', 'Noisy Samples', 'Reconstructed');
xlabel('Time (s)'); ylabel('Amplitude');
title('Noise Robustness – Under-sampling (fs = 10 Hz)');
grid on;

% Critical Sampling (fs = 14 Hz) ---
fs2 = 2 * f_max;  % 14 Hz
[t_sample2, x_sample2] = sample(t, xt, fs2);
noise2 = 0.2 * randn(size(x_sample2));
x_sample2_noisy = x_sample2 + noise2;
[~, x_rec2] = reconstruct(t_sample2, x_sample2_noisy, t_rec);

figure;
plot(t, xt, 'b'); hold on;
stem(t_sample2, x_sample2_noisy, 'r', 'filled');
plot(t_rec, x_rec2, 'g--');
legend('Original', 'Noisy Samples', 'Reconstructed');
xlabel('Time (s)'); ylabel('Amplitude');
title('Noise Robustness – Critical Sampling (fs = 14 Hz)');
grid on;

%Over-sampling (fs = 20 Hz) ---
fs3 = 20;
[t_sample3, x_sample3] = sample(t, xt, fs3);
noise3 = 0.2 * randn(size(x_sample3));
x_sample3_noisy = x_sample3 + noise3;
[~, x_rec3] = reconstruct(t_sample3, x_sample3_noisy, t_rec);

figure;
plot(t, xt, 'b'); hold on;
stem(t_sample3, x_sample3_noisy, 'r', 'filled');
plot(t_rec, x_rec3, 'g--');
legend('Original', 'Noisy Samples', 'Reconstructed');
xlabel('Time (s)'); ylabel('Amplitude');
title('Noise Robustness – Over-sampling (fs = 20 Hz)');
grid on;
