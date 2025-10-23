% Load saved recording that we had from voiceplot_ftr
load('my_recording.mat');  % should contain 'segment' and 'fs'

% Create time vector for original segment
t = (0:length(segment)-1) / fs;

% Desired sampling frequency
fs_new = 1300;  % example sampling frequency

% Sample the signal using your sample function
[t_sample, x_sample] = sample(t, segment, fs_new);

% Define reconstruction time vector (same resolution as original)
t_rec = t;  % reconstruct over original time points

% Reconstruct the signal using your reconstruct function
[t_rec, x_rec] = reconstruct(t_sample, x_sample, t_rec);

% Plot everything
figure;

% Original signal
plot(t, segment, 'b', 'LineWidth', 1.2);
hold on;

% Sampled points
stem(t_sample, x_sample, 'r', 'filled');

% Reconstructed signal
plot(t_rec, x_rec, 'g--', 'LineWidth', 1.5);

legend('Original Signal', 'Sampled Points', 'Reconstructed Signal');
xlabel('Time (s)');
ylabel('Amplitude');
title(['Sampling and Reconstruction (fs_{new} = ' num2str(fs_new) ' Hz)']);
grid on;
