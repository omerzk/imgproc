function image = IDWT(waveletDecomp,lowFilt,highFilt,levels)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cols = 1;
rows = 0;

if levels == 0
    image = waveletDecomp;
else
    %Parse wavelet decomposition
    [LL, LH, HL, HH] = parseWaveletDecomp(waveletDecomp);
    %Recursively re-compose LL
    LL = IDWT(LL, lowFilt, highFilt, levels - 1);
    %Adjust filters
    lowFilt = 2 * lowFilt; highFilt = highFilt(end:-1:1)*2;
    %Intermidiate product
    L = conv2(upSample(LL, rows), lowFilt', 'same') + conv2(upSample(LH, rows), highFilt', 'same');
    H = conv2(upSample(HL, rows), lowFilt', 'same') + conv2(upSample(HH, rows), highFilt', 'same');
    
    image = conv2(upSample(L, cols), lowFilt, 'same') + conv2(upSample(H, cols), highFilt, 'same');
end