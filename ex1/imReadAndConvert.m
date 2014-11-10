function im = imReadAndConvert(filename, representation)
%imReadAndConvert reads the image file, and converts it's color scheme.
%   single possible directional conversion is  rgb to grayscale.
GRAYSCALE = 1;

if(representation == GRAYSCALE)
    representation = 'grayscale';
else%if rep == 2 or not in {1,2} kindof Input check

    representation = 'truecolor';
end
    
srcInf = imfinfo(filename);
im = im2double(imread(filename));
%if the current represantaion is not the desired one.
if(~strcmp(srcInf.ColorType, representation))
    switch(representation)%for expandabilitys sake
        case 'grayscale'
            im = rgb2gray(im);
        case 'truecolor'
    end
end
end

