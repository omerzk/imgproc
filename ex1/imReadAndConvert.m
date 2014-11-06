function im = imReadAndConvert(filename, representation)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
GRAYSCALE = 1;

if(representation == GRAYSCALE)
    representation = 'grayscale';
else
    representation = 'truecolor';
end
    
im  = im2double(imread(filename));
srcInf = imfinfo(filename);

if(~strcmp(srcInf.ColorType, representation))   
    im = rgb2gray(im);
end

