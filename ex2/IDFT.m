function signal = IDFT(fourierSignal)
    N = length(fourierSignal);
    %x vector
    n = (0 : N-1); 
    % u matrix;
    u = n' * n;
    %e vector
    e = exp((2 * 1i * pi)/N);
    mat = e .^ u; % DFT matrix
    signal = real((mat' * fourierSignal')'/N);
end
