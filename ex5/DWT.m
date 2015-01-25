function waveletDecomp = DWT(image, lowFilt, highFilt, levels)
    upL = conv2(image, lowFilt,'same'); 
    upH = conv2(image, highFilt,'same'); 
    %Downsample
    L = upL(:, 1:2:end);
    H = upH(:, 1:2:end);
    %Convlute
    upLL = conv2(L, lowFilt', 'same'); upLH = conv2(L, highFilt', 'same'); 
    upHL = conv2(H, lowFilt', 'same'); upHH = conv2(H, highFilt', 'same');
    %Downsamples
    LL = upLL(1:2:end,:); LH = upLH(1:2:end,:); HL = upHL(1:2:end,:); HH = upHH(1:2:end,:);
    %Recurse
    if levels > 1% 1or0?
        LL = DWT(LL, lowFilt, highFilt,levels - 1);
    end
    
    waveletDecomp = [LL LH; HL HH];
end
