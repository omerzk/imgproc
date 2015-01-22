function [compressedImage,waveletDecompCompressed] = waveletQuantization(image,lowFilt,highFilt,levels,nQuant)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
waveletDecomp = DWT(image, lowFilt, highFilt, levels);%change  to uint8 before saving
save('beforeCompress.mat', 'waveletDecomp', '-v6');
waveletDecompCompressed = quant(waveletDecomp, levels, nQuant);
[LL, LH, HL, HH] = parseWaveletDecomp(waveletDecompCompressed);
LH = LH - min(LH(:))/max(LH(:));HL = HL - min(HL(:))/max(HL(:));
HH = HH - min(HH(:))/max(HH(:));
figure;imshow(waveletDecompCompressed);
save('afterCompress.mat', 'waveletDecompCompressed', '-v6');


compressedImage = IDWT(waveletDecompCompressed, lowFilt, highFilt, levels);

imshow(compressedImage,[]);
end

function waveletDecompCompressed = quant(waveletDecomp, levels, nQuant)
if levels == 0
    %normalize the LL to 0-255
    waveletDecompCompressed = waveletDecomp ;
else
    nIter = 8;
    [LL, LH, HL, HH] = parseWaveletDecomp(waveletDecomp);
    LL = quant(LL, levels - 1, nQuant);
    
    %Quantize details
    minLH = min(LH(:));
    minHL = min(HL(:));
    minHH = min(HH(:));
    im = [nan(size(LL)) LH-minLH; HL-minHL HH-minHH] ;
    imQ = quantizeImage(im, nQuant, nIter);
    [~, LH, HL, HH] = parseWaveletDecomp(imQ);
%     LHQ = quantizeImage(LH - min(LH(:)), nQuant, nIter) + min(LH(:));%TODO: +/- min
%     HLQ = quantizeImage(HL - min(HL(:)), nQuant, nIter) + min(HL(:));
%     HHQ = quantizeImage(HH - min(HH(:)), nQuant, nIter) + min(HH(:));
    waveletDecompCompressed = [LL LH+minLH; HL+minHL HH+minHH];
    
    
end
end