% Define signal
t = linspace(0, 1, 1000); % one period
xt = cos(2*pi*3*t) + 0.5*cos(2*pi*7*t);
T = 1; % period

% Compute CTFT
[f, xf, W] = ftr(t, xt, T);

% Plot full Fourier Transform
figure;
plot(f, abs(xf), 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
title('Continuous-Time Fourier Transform');
grid on;
xlim([-20 20]);

%samples at integer harmonics (n/T)
n = -20:20; % range of harmonics
freq_samples = n / T; % frequencies to sample
coef_samples = zeros(size(freq_samples));

% For each harmonic, we find closest value in f array
for k = 1:length(freq_samples)
    [~, idx] = min(abs(f - freq_samples(k)));
    coef_samples(k) = xf(idx);
end

% Plot coefficients
figure;
stem(n, abs(coef_samples), 'r', 'filled');
xlabel('Harmonic (n)'); ylabel('|Coefficient|');
title('Fourier Series Coefficients from FT Sampling');
grid on;
