function im = imReadAndConvert(filename, representation)
%imReadAndConvert reads the image file, and converts it's color scheme.
%   single possible directional conversion is  rgb to grayscale.
GRAYSCALE = 1;

if(representation == GRAYSCALE)
    representation = 'grayscale';
else
    representation = 'truecolor';
end
    
srcInf = imfinfo(filename);
im = im2double(imread(filename));
%if the current represantaion is not the desired one/
if(~strcmp(srcInf.ColorType, representation))   
    im = rgb2gray(im);
end

