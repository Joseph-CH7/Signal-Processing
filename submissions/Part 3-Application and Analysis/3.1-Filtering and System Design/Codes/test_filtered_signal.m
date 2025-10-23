% Load saved recording
load('my_recording.mat');  % loads y and fs

% Extract from 3 to 5 seconds
start_idx = round(3 * fs) + 1;
end_idx = round(5 * fs);
segment = y(start_idx:end_idx);
t_seg = (0:length(segment)-1)/fs;

% Call filter function
filtered_segment = apply_lpf(segment, fs);

% Plot original vs filtered signal (time domain)
figure;
plot(t_seg, segment, 'b', 'LineWidth', 1);
hold on;
plot(t_seg, filtered_segment, 'r', 'LineWidth', 1.5);
legend('Original Signal', 'Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original vs Filtered Signal (Time Domain)');
grid on;

% Fourier Transform original signal using ftr
T_seg = t_seg(end) - t_seg(1);
[f_orig, xf_orig, ~] = ftr(t_seg, segment, T_seg);

% Fourier Transform filtered signal using ftr
[f_filt, xf_filt, ~] = ftr(t_seg, filtered_segment, T_seg);

% Plot frequency spectra
figure;
plot(f_orig, abs(xf_orig)/max(abs(xf_orig)), 'b', 'LineWidth', 1);
hold on;
plot(f_filt, abs(xf_filt)/max(abs(xf_filt)), 'r', 'LineWidth', 1);
legend('Original Spectrum', 'Filtered Spectrum');
xlabel('Frequency (Hz)');
ylabel('|X(f)| Normalized');
title('Frequency Spectrum Before and After Filtering (using ftr)');
xlim([0 fs/2]);
grid on;
