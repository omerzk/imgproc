function imRGB = transformYIQ2RGB(imYIQ)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
imY = imYIQ(:, :, 1);
imI = imYIQ(:, :, 2);
imQ = imYIQ(:, :, 3);

imR = imY + 0.956.*imI + 0.621.*imQ;
imG = imY - 0.272.*imI - 0.647.*imQ;
imB = imY - 1.108.*imI + 1.705.*imQ;

imRGB = cat(3, imR, imG, imB);
end

