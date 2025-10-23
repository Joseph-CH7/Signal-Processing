function [t, xt_rec, T] = iftr(f, xf, W)
% iftr:Manual numerical approximation of the Inverse Continuous-Time Fourier Transform (CTFT)
% Inputs:
%   f:frequency vector (sampled)
%   xf:Fourier transform values at frequencies f
%   W:total bandwidth
% Outputs:
%   t: time vector
%   xt_rec:reconstructed signal
%   T: total duration

    deltaF = f(2) - f(1);   % Frequency step
    N = length(f);          % Number of frequency samples

    % Time vector
    T = 1/deltaF;          
    t = (-1/(2*deltaF)) : (1/T) : (1/(2*deltaF));
    
    % Initialize xt_rec
    xt_rec = zeros(size(t));

    % Manual computation of Inverse CTFT (numerical summation)
    for n = 1:length(t)
        for k = 1:length(f)
            xt_rec(n) = xt_rec(n) + xf(k) * exp(1i*2*pi*f(k)*t(n)) * deltaF;
        end
    end
end
