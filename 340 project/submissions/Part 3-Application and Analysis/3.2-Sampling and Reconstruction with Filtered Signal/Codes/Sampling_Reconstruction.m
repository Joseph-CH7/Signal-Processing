% Load saved recording
load('my_recording.mat');  % loads y and fs

% Extract from 3 to 5 seconds
start_idx = round(3 * fs) + 1;
end_idx = round(5 * fs);
segment = y(start_idx:end_idx);
t_seg = (0:length(segment)-1)/fs;

% Call filter function to get filtered signal
filtered_segment = apply_lpf(segment, fs);

% Sampling rates to test
fs_news = [600, 1800, 5000];  % example sampling rates

for i = 1:length(fs_news)
    fs_new = fs_news(i);
    
    % Sample original signal
    [t_sample_orig, x_sample_orig] = sample(t_seg, segment, fs_new);
    
    % Sample filtered signal
    [t_sample_filt, x_sample_filt] = sample(t_seg, filtered_segment, fs_new);
    
    % Reconstruct original signal
    [t_rec, x_rec_orig] = reconstruct(t_sample_orig, x_sample_orig, t_seg);
    
    % Reconstruct filtered signal
    [~, x_rec_filt] = reconstruct(t_sample_filt, x_sample_filt, t_seg);
    
    % Plot original signal reconstruction
    figure;
    plot(t_seg, segment, 'b', 'LineWidth', 1);
    hold on;
    stem(t_sample_orig, x_sample_orig, 'r', 'filled');
    plot(t_seg, x_rec_orig, 'g--', 'LineWidth', 1.5);
    legend('Original Signal', 'Sampled Points', 'Reconstructed Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Original Signal Reconstruction (fs_{new} = ' num2str(fs_new) ' Hz)']);
    grid on;
    
    % Plot filtered signal reconstruction
    figure;
    plot(t_seg, filtered_segment, 'b', 'LineWidth', 1);
    hold on;
    stem(t_sample_filt, x_sample_filt, 'r', 'filled');
    plot(t_seg, x_rec_filt, 'g--', 'LineWidth', 1.5);
    legend('Filtered Signal', 'Sampled Points', 'Reconstructed Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Filtered Signal Reconstruction (fs_{new} = ' num2str(fs_new) ' Hz)']);
    grid on;
    % Compute error for original signal
    err_orig = sum(abs(segment - x_rec_orig).^2) * (t_seg(2) - t_seg(1));
    
    % Compute error for filtered signal
    err_filt = sum(abs(filtered_segment - x_rec_filt).^2) * (t_seg(2) - t_seg(1));
    
    % Display errors
    disp(['Sampling rate fs_new = ' num2str(fs_new) ' Hz:']);
    disp(['Error (original signal) = ' num2str(err_orig)]);
    disp(['Error (filtered signal) = ' num2str(err_filt)]);
    disp('--------------------------------------------');
end
