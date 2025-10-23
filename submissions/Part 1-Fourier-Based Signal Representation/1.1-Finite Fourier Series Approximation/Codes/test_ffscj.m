% Test 1: Gaussian pulse
t = linspace(-2, 2, 1000);
xt = exp(-t.^2);
n = 20; T = 4;
[xhat, ck] = ffscj(xt, t, n, T);

% Plot
plot(t, xt, 'k', 'LineWidth', 1.5); hold on;
plot(t, real(xhat), 'r--', 'LineWidth', 1.5);
legend('Original', 'Fourier Approx');
xlabel('Time'); ylabel('x(t)');
title('Fourier Series Approximation Carl&Josheph');
grid on;

% Test 2: Sine pulse (limited time support)
t = linspace(-2, 2, 1000);
xt = sin(2*pi*t) .* (abs(t) < 1);  % Zero outside [-1,1]
n = 20; T = 4;
[xhat, ck] = ffscj(xt, t, n, T);

% Plot
figure;
plot(t, xt, 'b', 'LineWidth', 1.5); hold on;
plot(t, real(xhat), 'r--', 'LineWidth', 1.5);
legend('Original', 'Fourier Approx');
xlabel('Time'); ylabel('x(t)');
title('Sine Pulse Fourier Approximation');
grid on;

%step 1:changing values of n
ns = 1:50;               % Range of harmonic counts
errs = zeros(size(ns));  % To store errors
T = 4;                   % Keep period fixed

for i = 1:length(ns)
    [xhat_i, ~] = ffscj(xt, t, ns(i), T);
    errs(i) = sum(abs(xt - real(xhat_i)).^2) * (t(2) - t(1));
end

figure;
plot(ns, errs, 'LineWidth', 1.5);
xlabel('Number of Harmonics (n)');
ylabel('Squared Error');
title('Error vs. Number of Harmonics');
grid on;

%step 2:changing values of T
T_values = [2, 4, 6];
colors = ['r', 'g', 'b'];
figure;

for j = 1:length(T_values)
    T = T_values(j);
    for i = 1:length(ns)
        [xhat_i, ~] = ffscj(xt, t, ns(i), T);
        errs(i) = sum(abs(xt - real(xhat_i)).^2) * (t(2) - t(1));
    end
    plot(ns, errs, 'Color', colors(j), 'DisplayName', ['T = ' num2str(T)]); hold on;
end

xlabel('n'); ylabel('Error');
title('Error vs. n for different T');
legend show; grid on;
