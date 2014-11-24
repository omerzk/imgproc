function fourierSignal = DFT(signal)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes her
    N = length(signal);
    %x vector
    n = (0 : N-1); 
    % u matrix;
    u = n' * n; 
    %e vector
    e = exp((-2 * 1i * pi) / N);
    exp_mat = e .^ u; % DFT 
    fourierSignal = (exp_mat' * signal')';
end
