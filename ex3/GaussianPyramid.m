function [pyr, filter] = GaussianPyramid(im, maxLevels, filterSize)
    pyr = cell(1,1);
    %blur filter
    %the famous k from nCk
    kvec = (0 : filterSize-1);
    nvec = (ones(1, filterSize) * filterSize - 1);
    %nCk  
    binomial_co = (factorial(nvec)./(factorial(kvec) .* factorial(nvec - kvec)));
    filter = binomial_co./sum(binomial_co(:));
    
    pyr(1,1) = {im};
    i = 2;
    
    while(i <= maxLevels && sum(size(pyr{i-1}) > 16) == 2)
        %==========Reduce=======
        %Blur
        blurred = conv2(conv2(pyr{i-1}, filter,'same'), filter','same');
        %Sample and assign
        pyr(1,i) = {blurred(1:2:end,1:2:end)};
        %=======================
        i = i + 1;
    end
    end 