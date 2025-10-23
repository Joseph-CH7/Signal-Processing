%% Test 1: Rectangular pulse -> Sinc in frequency
figure;
t = linspace(-5, 5, 1000);
xt = double(abs(t) <= 0.5);  % rect(t) of width 1
T = t(end) - t(1);

[f, xf, W] = ftr(t, xt, T);

subplot(2,1,1);
plot(t, xt, 'b', 'LineWidth', 1.5);
xlabel('Time (t)'); ylabel('Amplitude');
title('Rectangular Pulse in Time');
axis([-2 2 -0.2 1.2]); % Focus around the pulse
grid on;

subplot(2,1,2);
plot(f, abs(xf)/max(abs(xf)), 'r', 'LineWidth', 1.5);
xlabel('Frequency (f)'); ylabel('|X(f)|');
title('Expected Sinc Function in Frequency');
xlim([-20 20]); ylim([0 1.2]); % Zoom around the main lobe
grid on;

%% Test 2: Sinc pulse -> Rectangular in frequency
figure;
t = linspace(-10, 10, 2000);
xt = sin(pi*t) ./ (pi*t);
xt(t==0) = 1;
T = t(end) - t(1);

[f, xf, W] = ftr(t, xt, T);

subplot(2,1,1);
plot(t, xt, 'b', 'LineWidth', 1.5);
xlabel('Time (t)'); ylabel('Amplitude');
title('Sinc Pulse in Time');
axis([-10 10 -0.5 1.2]); % Focus on main lobes
grid on;

subplot(2,1,2);
plot(f, abs(xf)/max(abs(xf)), 'r', 'LineWidth', 1.5);
xlabel('Frequency (f)'); ylabel('|X(f)|');
title('Expected Rectangular Function in Frequency');
xlim([-2 2]); ylim([0 1.2]); % Zoom in around rectangle
grid on;

%% Test 3: Constant signal -> Delta function in frequency
figure;
t = linspace(-5,5,1000);
xt = ones(size(t));
T = t(end) - t(1);

[f, xf, W] = ftr(t, xt, T);

subplot(2,1,1);
plot(t, xt, 'b', 'LineWidth', 1.5);
xlabel('Time (t)'); ylabel('Amplitude');
title('Constant Signal in Time');
axis([-5 5 0.8 1.2]); % Zoom around constant level
grid on;

subplot(2,1,2);
plot(f, abs(xf)/max(abs(xf)), 'r', 'LineWidth', 1.5);
xlabel('Frequency (f)'); ylabel('|X(f)|');
title('Expected Delta-like Peak in Frequency');
xlim([-5 5]); ylim([0 1.2]); % Focus around f = 0
grid on;
