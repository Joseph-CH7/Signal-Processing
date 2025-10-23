% Load saved recording
load('my_recording.mat');  % loads y and fs

% Extract from 3 to 5 seconds
start_idx = round(3 * fs) + 1;
end_idx = round(5 * fs);
segment = y(start_idx:end_idx);
t_seg = (0:length(segment)-1)/fs;

% Filter the signal
filtered_segment = apply_lpf(segment, fs);

% Sampling rate
fs_new = 1800;  

% Sample original and filtered signals
[t_sample_segment, x_sample_segment] = sample(t_seg, segment, fs_new);
[t_sample_filtered, x_sample_filtered] = sample(t_seg, filtered_segment, fs_new);

% Add noise
noise_level = 0.01;  
x_sample_segment_noisy = x_sample_segment + noise_level * randn(size(x_sample_segment));
x_sample_filtered_noisy = x_sample_filtered + noise_level * randn(size(x_sample_filtered));

% Reconstruct from noisy samples
[t_rec, x_rec_segment_noisy] = reconstruct(t_sample_segment, x_sample_segment_noisy, t_seg);
[~, x_rec_filtered_noisy] = reconstruct(t_sample_filtered, x_sample_filtered_noisy, t_seg);

%Plot reconstructed original signal
figure;
plot(t_seg, segment, 'b', 'LineWidth', 1.2); hold on;
stem(t_sample_segment, x_sample_segment_noisy, 'r');
plot(t_rec, x_rec_segment_noisy, 'g--', 'LineWidth', 1.5);
legend('Original Signal', 'Noisy Sampled Points (Original)', 'Reconstructed from Noisy (Original)');
xlabel('Time (s)'); ylabel('Amplitude');
title(['Reconstruction from Noisy Samples (Original, fs_{new} = ' num2str(fs_new) ' Hz)']);
grid on;

% Plot reconstructed filtered signal (against filtered_segment)
figure;
plot(t_seg, filtered_segment, 'b', 'LineWidth', 1.2); hold on;
stem(t_sample_filtered, x_sample_filtered_noisy, 'r');
plot(t_rec, x_rec_filtered_noisy, 'g--', 'LineWidth', 1.5);
legend('Filtered Signal', 'Noisy Sampled Points (Filtered)', 'Reconstructed from Noisy (Filtered)');
xlabel('Time (s)'); ylabel('Amplitude');
title(['Reconstruction from Noisy Samples (Filtered, fs_{new} = ' num2str(fs_new) ' Hz)']);
grid on;

% Ensure column vectors for error computation
segment = segment(:);
filtered_segment = filtered_segment(:);
x_rec_segment_noisy = x_rec_segment_noisy(:);
x_rec_filtered_noisy = x_rec_filtered_noisy(:);

% Compute errors
err_segment_noisy = mean((segment - x_rec_segment_noisy).^2);
err_filtered_noisy = mean((filtered_segment - x_rec_filtered_noisy).^2);  % comparing to filtered reference

%Display errors 
disp(['Reconstruction error (Original signal, noisy samples): ', num2str(err_segment_noisy)]);
disp(['Reconstruction error (Filtered signal, noisy samples): ', num2str(err_filtered_noisy)]);
