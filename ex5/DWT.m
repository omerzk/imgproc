function waveletDecomp = DWT(image, lowFilt, highFilt, levels)
%DWT performs #levels discrete wavelet transform of image.  
%   image is a input image.
%   lowFilt is a row vector representing the scaling (or approximation)
%   function which acts as a low pass filter.
%   highFilt is a row vector representing the wavelet function which acts as a high pass filter.
%    lowFilt = 1/2*[1 1] , highFilt = 12 [1, −1].
    %Works under the assumption that LL spatial domains are divisable by 2
    %Convlute
    
    waveletDecomp = recDWT(image, lowFilt, highFilt, levels);
    %Normalize to [0,1] 
    dispImage = (waveletDecomp - min(waveletDecomp(:)))/max(waveletDecomp(:));
    figure;imshow(dispImage,[]);
end

function waveletDecomp = recDWT(image, lowFilt, highFilt, levels)
    upL = conv2(image, lowFilt,'same'); 
    upH = conv2(image, highFilt,'same'); 
    %Downsample
    L = upL(:, 1:2:end);
    H = upH(:, 1:2:end);
    %Convlute
    upLL = conv2(L, lowFilt', 'same'); upLH = conv2(L, highFilt', 'same'); 
    upHL = conv2(H, lowFilt', 'same'); upHH = conv2(H, highFilt', 'same');
    %Downsample
    LL = upLL(1:2:end,:); LH = upLH(1:2:end,:); HL = upHL(1:2:end,:); HH = upHH(1:2:end,:);
    %Recurse
    if levels > 1
        LL = recDWT(LL, lowFilt, highFilt,levels - 1);
    end
    
    waveletDecomp = [LL LH; HL HH];
end
