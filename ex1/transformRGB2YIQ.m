function imYIQ = transformRGB2YIQ(imRGB)
%UNTITLED2 Summary of this function goes here
%   Y=0.30R+0.59G+0.11B
%   I=0.60R-0.28G-0.32B
%   Q=0.21R-0.52G+0.31B
imR = imRGB(:, :, 1);
imG = imRGB(:, :, 2);
imB = imRGB(:, :, 3);

imY = 0.299.*imR + 0.587.*imG + 0.114.*imB;
imI = 0.596.*imR - 0.275.*imG - 0.321.*imB;
imQ = 0.212.*imR - 0.523.*imG - 0.311.*imB;

imYIQ = cat(3, imY, imI, imQ);

end
