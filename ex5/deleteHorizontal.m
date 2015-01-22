function outImage = deleteHorizontal(image,lowFilt,highFilt,levels)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
decomp = DWT(image, lowFilt, highFilt, levels);
outDecomp = deleteHor(decomp, levels);
outImage = IDWT(outDecomp, lowFilt, highFilt, levels);

end

function outDecomp = deleteHor(image,levels)
    if levels == 0
        outDecomp = image;
    else 
    [LL, LH, HL, HH] = parseWaveletDecomp(image);
    LL = deleteHor(LL,levels - 1);
    %LH = HH; % might be a bit better could improve more
    %LH = medfilt2(LH)
    LH = zeros(size(LH));% basic approach
    outDecomp = [LL LH; HL HH];
    end
end
    
