function blurImage = blurInFourierSpace(inImage,kernelSize)
    %the famous k from nCk
    kvec = (0 : kernelSize-1);
    nvec = (ones(1,kernelSize) * kernelSize-1);
    %nCk  
    d1 = (factorial(nvec)./(factorial(kvec).*factorial(nvec-kvec)));
    %create the gaussian matrix
    gaussian = d1' * d1;
    gaussian = gaussian./sum(sum(gaussian));
    ft = DFT2(inImage);
    [N, M] = size(inImage);
    gaussain_ft = zeros(N, M);
    Mstart = floor(M/2) + 1;
    Nstart = floor(N/2) + 1;
    gaussain_ft(Mstart : Mstart + kernelSize-1 , Nstart : Nstart + kernelSize-1) = DFT2(gaussian);
    blurImage = IDFT2((ifftshift(gaussain_ft).*ft));
    
end
