function imYIQ = transformRGB2YIQ(imRGB)
%transformRGB2YIQ takes an RGB image and returns it's YIQ representation
%   Y = 0.30R + 0.59G + 0.11B
%   I = 0.60R - 0.28G - 0.32B
%   Q = 0.21R - 0.52G + 0.31B
M = [0.299 0.587 0.114; 0.595716 -0.274453 -0.321263; 0.211456 -0.522591 0.311135];
imYIQ = reshape(reshape(imRGB, [], 3) * M', size(imRGB));

end

