function [imEq, histOrig, histEq] = histogramEqualize(imOrig)
%histogramEqualize - takes an image(doubles) and performs
%histogram equalization on it. 
%   the function takes either a grayscale or a truecolor image 
%   as a double matrix.it returns the equalized image, the original
%   histogram and the equalized histogram.

figure('name', 'Original image', 'NumberTitle', 'off'); imshow(imOrig);
%Input check
if(~isfloat(imOrig))
    imOrig = im2double(imOrig);
end

%if the image is in RGB
if(ndims(imOrig) == 3)
    imYIQ = transformRGB2YIQ(imOrig);
    channel = im2uint8(imYIQ(:, :, 1));
    truecolor = true;
else
    channel = im2uint8(imOrig);
    truecolor = false;
end

histOrig = imhist(channel);
cumHist = cumsum(histOrig);

%normalize the cumalative histogram
histEq = round((cumHist * 255) / cumHist(256,1));

%use the normalized histogram as a lookup table
channel = im2double(histEq(channel + 1)/255);

%stretch the output of the equlization to [0..1]
channel = (channel - min(min(channel)))*(1/max(max(channel)));

if (truecolor)
    imYIQ(:, :, 1) = channel;
    imEq = transformYIQ2RGB(imYIQ);
else
    imEq = channel;
end

figure('name', 'Equalized Image', 'NumberTitle', 'off'); imshow(imEq);
end


