function signal = IDFT(fourierSignal)
%IDFT returns the inverse discrete fourier transform of the input signal
    N = length(fourierSignal);
    %x vector
    n = (0 : N-1); 
    % u matrix;
    u = n' * n;
    %e vector
    e = exp((2 * 1i * pi)/N);
    mat = e .^ u; % DFT matrix
    signal = (mat' * fourierSignal')'/N;
end
