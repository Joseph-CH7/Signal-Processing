f0_real = 5; % Hz - true signal frequency
fs = 8; % Sampling frequency (Hz)
t = linspace(0, 1, 1000); % Fine time vector
xt_real = cos(2*pi*f0_real*t); % True original signal

% Create a fine-time signal that would alias
f0_alias = fs - f0_real; % 8 - 5 = 3 Hz
xt_alias = cos(2*pi*f0_alias*t); % Aliased signal

% Sample both signals
[t_sample, x_sample_real] = sample(t, xt_real, fs);
[~, x_sample_alias] = sample(t, xt_alias, fs);

% Plot original continuous signals
figure;
plot(t, xt_real, 'b', 'LineWidth', 1.5); hold on;
plot(t, xt_alias, 'g--', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
legend('Original cos(2π5t)', 'Aliased cos(2π3t)');
title('Continuous-Time Signals Before Sampling');
grid on;

% Plot sampled points
figure;
stem(t_sample, x_sample_real, 'r', 'filled'); hold on;
stem(t_sample, x_sample_alias, 'm', 'filled');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Samples from cos(2π5t)', 'Samples from cos(2π3t)');
title('Sampled Signals (fs = 8 Hz)');
grid on;

%% EXTRA TEST: Sampling cos(2π6t) at fs = 8Hz

f0_extra = 6; % Hz
t = linspace(0, 1, 1000);
xt_extra = cos(2*pi*f0_extra*t);

[t_sample_extra, x_sample_extra] = sample(t, xt_extra, fs);

% Plot continuous signal
figure;
plot(t, xt_extra, 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Continuous-Time Signal: cos(2π6t)');
grid on;

% Plot sampled points
figure;
stem(t_sample_extra, x_sample_extra, 'r', 'filled');
xlabel('Time (s)'); ylabel('Amplitude');
title('Sampled Points from cos(2π6t) at fs = 8 Hz (Aliasing to 2Hz)');
grid on;
