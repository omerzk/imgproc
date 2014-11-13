function imDisplay(filename, representation)
%imDisplay 
%   displays an image and info on the intensity of the pixel when the mouse
%   hovers over it
impixelinfo(imshow(imReadAndConvert(filename, representation)));

end

