function signal = IDFT(fourierSignal)
%IDFT returns the inverse discrete fourier transform of the input signal
    s = size(fourierSignal);
    N = s(2);
    %x vector
    n = (0 : N-1); 
    % u matrix;
    u = n' * n;
    %e vector
    e = exp((2 * 1i * pi)/N);
    mat = e .^ u; % DFT matrix
    signal = (mat' * fourierSignal')'/N;
end
