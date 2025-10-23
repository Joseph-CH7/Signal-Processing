function [xhat, ck] = ffscj(xt, t, n, T)
    % ffs - Finite Fourier Series approximation
    dt = t(2) - t(1);
    ck = zeros(2*n+1, 1);
    xhat = zeros(size(t));
    
    for k = -n:n
        idx = k + n + 1;
        ck(idx) = (1/T) * sum(xt .* exp(-1j*2*pi*k*t/T)) * dt;
        xhat = xhat + ck(idx) * exp(1j*2*pi*k*t/T);
    end
end
