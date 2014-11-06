function [imEq, histOrig, histEq] = histogramEqualize(imOrig)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if(imfinfo(imOrig).ColorType == 'truecolor')
    ImYIQ = transformRGB2YIQ(imOrig);%since i cant use a temp var
    channel = im2uint8(ImYIQ(:, :, 1));
else
    channel = im2uint8(imOrig);  
end
histOrig = imhist(channel);
dim = size(imOrig);
LUT = round((cumsum(histOrig) * 255) / (dim(1) * dim(2)));

    
end


