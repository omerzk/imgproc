function blurImage = blurInFourierSpace(inImage,kernelSize)
    %the famous k from nCk
    kvec = (0 : kernelSize-1);
    nvec = (ones(1,kernelSize) * kernelSize-1);
    %nCk  
    d1 = (factorial(nvec)./(factorial(kvec).*factorial(nvec-kvec)));
    %create the gaussian matrix
    gaussian = d1' * d1;
    gaussian = gaussian./sum(sum(gaussian));
    [N, M] = size(inImage);
    gaussain_ft = zeros(N, M);
    %insert the gaussian intothe center of a zero matrix  
    Mstart = floor(M / 2) + 1;
    Nstart = floor(N / 2) + 1;
    leg = floor(kernelSize / 2);
    gaussain_ft(Mstart - leg :Mstart + leg, Nstart - leg:Nstart + leg )= gaussian;
    %fourier transform of each of the operands
    ftIm = DFT2(inImage);
    gaussain_ft = DFT2(gaussain_ft);
    
    blurImage = ifftshift(IDFT2((gaussain_ft .* ftIm)));
    
    
end
