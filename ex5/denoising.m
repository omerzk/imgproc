function denoisImage = denoising(image,lowFilt,highFilt,levels)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
decomp = DWT(image, lowFilt, highFilt, levels);
denoisedDecomp = denoise(decomp,levels);
denoisImage = IDWT(denoisedDecomp, lowFilt, highFilt, levels);

end


function denoisedDecomp = denoise(decomp,levels)
    if levels == 0
        denoisedDecomp = decomp;
    else 
    [LL, LH, HL, HH] = parseWaveletDecomp(decomp);
    LL = denoise(LL, levels - 1);
    %Threshold
   %thresh = @(x)max(x(:))/2.2;
    %thresh = @(x)4.5 * std2(x);
    thresh = @(x)2 * std2(x);
    LH(abs(LH) < thresh(LH)) = 0;
    HL(abs(HL) < thresh(HL)) = 0;
    HH(abs(HH) < thresh(HH)) = 0;
    denoisedDecomp = [LL LH; HL HH];
    end
end
    
