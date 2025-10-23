 % Load the recorded voice segment
load('my_recording.mat');  % contains variable 'y' and 'fs'

% Extract a clean segment (e.g., 3s–5s)
start_idx = round(2.5 * fs);
end_idx = round(4.5 * fs);
segment = y(start_idx:end_idx);
t = (0:length(segment)-1) / fs;

% Uniform Quantization 
step_u = 0.2;
x_uniform = round(segment / step_u) * step_u;

%  Non-Uniform Quantization 
x_nonuniform = zeros(size(segment));
for i = 1:length(segment)
    val = segment(i);
    if abs(val) <= 0.2
        step = 0.05;
    elseif abs(val) <= 0.5
        step = 0.1;
    else
        step = 0.25;
    end
    x_nonuniform(i) = round(val / step) * step;
end

% Sampling
fs_sample = 1000;
[t_sample, x_sample] = sample(t, segment, fs_sample);
[~, x_uniform_sample] = sample(t, x_uniform, fs_sample);
[~, x_nonuniform_sample] = sample(t, x_nonuniform, fs_sample);

%Reconstruction
t_rec = t;
[~, x_rec] = reconstruct(t_sample, x_sample, t_rec);
[~, x_uniform_rec] = reconstruct(t_sample, x_uniform_sample, t_rec);
[~, x_nonuniform_rec] = reconstruct(t_sample, x_nonuniform_sample, t_rec);

% Plot: Original vs Quantized
figure;
plot(t, segment, 'b'); hold on;
plot(t, x_uniform, 'r--');
plot(t, x_nonuniform, 'g:');
legend('Original', 'Uniform Quantized', 'Non-Uniform Quantized');
xlabel('Time (s)'); ylabel('Amplitude');
title('Original vs Uniform vs Non-Uniform Quantized');
grid on;

% Plot: Reconstructed Signals 
figure;
plot(t, segment, 'b'); hold on;
plot(t_rec, x_uniform_rec, 'r--');
plot(t_rec, x_nonuniform_rec, 'g-.');
legend('Original', 'Reconstructed (Uniform)', 'Reconstructed (Non-Uniform)');
xlabel('Time (s)'); ylabel('Amplitude');
title('Reconstruction: Uniform vs Non-Uniform Quantized');
grid on;

%Plot: Reconstruction Error
figure;
plot(t_rec, abs(x_rec - x_uniform_rec), 'r', 'LineWidth', 1.2); hold on;
plot(t_rec, abs(x_rec - x_nonuniform_rec), 'g', 'LineWidth', 1.2);
legend('|Original - Uniform|', '|Original - Non-Uniform|');
xlabel('Time (s)'); ylabel('Absolute Error');
title('Reconstruction Error Comparison');
grid on;
