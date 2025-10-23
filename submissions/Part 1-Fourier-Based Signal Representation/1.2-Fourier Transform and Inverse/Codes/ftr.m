function [f, xf, W] = ftr(t, xt, T)
% ftr:Manual numerical approximation of the Continuous-Time Fourier Transform (CTFT)
% Inputs:
%   t:time vector (sampled)
%   xt:signal values at time t
%   T:total duration (T = t(end) - t(1))
% Outputs:
%   f:frequency vector
%   xf:Fourier transform values
%   W:total bandwidth

    deltaT = t(2) - t(1);  % Time step
    N = length(t);         % Number of time samples

    % Frequency vector
    f = (-1/(2*deltaT)) : (1/T) : (1/(2*deltaT));
    
    % Range of frequencies
    W = max(f) - min(f);

    % Initialize xf
    xf = zeros(size(f));

    % Manual computation of CTFT integral (numerical summation)
    for k = 1:length(f)
        for n = 1:length(t)
            xf(k) = xf(k) + xt(n) * exp(-1i*2*pi*f(k)*t(n)) * deltaT;
        end
    end
end
