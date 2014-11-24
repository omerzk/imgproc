function blurImage = blurInImageSpace(inImage,kernelSize)
    %the famous k from nCk
    kvec = (0 : kernelSize-1);
    nvec = (ones(1,kernelSize) * kernelSize-1);
    %nCk  
    d1 = (factorial(nvec)./(factorial(kvec).*factorial(nvec-kvec)));
    %create the gaussian matrix
    gaussian = d1' * d1;
    gaussian = gaussian./sum(sum(gaussian));
    %blur
    blurImage = conv2(inImage,gaussian);
    
end