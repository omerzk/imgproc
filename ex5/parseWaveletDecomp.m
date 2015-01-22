function [LL, LH, HL, HH] = parseWaveletDecomp(waveletDecomp)
    sz = size(waveletDecomp);
    
    halfHeight = floor(sz(1)/2); halfWidth = floor(sz(2)/2);

    LL = waveletDecomp(1:halfHeight, 1:halfWidth);
    LH = waveletDecomp(1:halfHeight, halfWidth + 1:end);
    HL = waveletDecomp(halfHeight+1: end, 1:halfWidth);
    HH = waveletDecomp(halfHeight+1: end, halfWidth + 1:end);
end