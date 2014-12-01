function fourierSignal = DFT(signal)
%DFT returns the discrete fourier transform of the input signal
    s = size(signal);
    N = s(2);
    %x vector
    n = (0 : N-1); 
    % u matrix;
    u = n' * n; 
    %e vector
    e = exp((-2 * 1i * pi) / N);
    exp_mat = e .^ u; % DFT 
    fourierSignal = (exp_mat' * signal')';
end
