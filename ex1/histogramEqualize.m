function [imEq, histOrig, histEq] = histogramEqualize(imOrig)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

dim = size(size(imOrig));
if( dim(2)== 3)
    imYIQ = transformRGB2YIQ(imOrig);
    channel = im2uint8(imYIQ(:, :, 1));
    truecolor = 1;
else
    channel = im2uint8(imOrig);
    truecolor = 2;
end

histOrig = imhist(channel);
cumHist = cumsum(histOrig);
histEq = round((cumHist * 255) / cumHist(256,1));
channel= im2double(histEq(channel + 1)/255);

if (truecolor == 1)
    imYIQ(:, :, 1) = channel;
    imEq = transformYIQ2RGB(imYIQ);
else
    imEq = channel;
end

end


