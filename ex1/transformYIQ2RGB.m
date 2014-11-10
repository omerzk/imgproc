function imRGB = transformYIQ2RGB(imYIQ)
%transformYIQ2RGB takes a YIQ image and returns it's RGB representation
%  R = Y + 0.956 * I + 0.621 * Q;
%  G = Y - 0.272 * I - 0.647 * Q;
%  B = Y - 1.108 * I + 1.705 * Q;

%Input checks
if(~isfloat(imRGB))
    imYIQ = im2double(imYIQ);
end

M = [1 0.9563 0.6210; 1 -0.2721 -0.6474; 1 -1.1070 1.7046];
imRGB = reshape(reshape(imYIQ, [], 3) * M', size(imYIQ));
end
