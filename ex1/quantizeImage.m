function [imQuant, error] = quantizeImage(imOrig, nQuant, nIter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure('name', 'Original image','NumberTitle', 'off');
imshow(imOrig);
if ndims(imOrig) == 3
    imYIQ = transformRGB2YIQ(imOrig);
    channel = im2uint8(imYIQ(:, :, 1));
    truecolor = true;
else
    channel = im2uint8(imOrig);
    truecolor = false;
end
cumhist = cumsum(imhist(channel));
pixels_per_seg = round(cumhist(256,1)/nQuant);
z = find(mod(cumhist,pixels_per_seg) == 0)
z(nQuant) = 256;
q = zeros(nQuant);
imQuant = 2;
error = 3;
    
    



end

