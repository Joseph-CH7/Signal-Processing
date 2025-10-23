fs = 4000; % Sampling frequency
recObj = audiorecorder(fs, 16, 1); % Mono, 16-bit

disp('Start speaking...');
recordblocking(recObj, 6);
disp('End of recording.');

% Get the audio data
y = getaudiodata(recObj);
t = (0:length(y)-1)/fs;

% Plot the full 6-second signal
figure;
plot(t, y);
title('Full Recorded Voice Signal (6 seconds)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Extract from 3 seconds to 5 seconds
start_time = 3; % seconds
end_time = 5;   % seconds
start_idx = round(start_time * fs) + 1;
end_idx = min(round(end_time * fs), length(y)); % ensure we stay in bounds

segment = y(start_idx:end_idx);
t_seg = t(start_idx:end_idx);

% Plot the extracted segment
figure;
plot(t_seg, segment);
title('Extracted Voice Segment (3s to 5s)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Print waiting message
disp('Please wait while we generate the signal...');

% Compute Fourier Transform using ftr
T = t_seg(end) - t_seg(1);  % total duration
[f, xf, W] = ftr(t_seg, segment, T);

% Plot frequency spectrum
figure;
plot(f, abs(xf)/max(abs(xf)), 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('|X(f)| Normalized');
title('Frequency Spectrum of Extracted Segment');
xlim([0, max(f)]); % positive frequency range
grid on;

% Save the recording
save('my_recording.mat', 'y', 'fs');
