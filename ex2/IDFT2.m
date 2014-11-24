function image = IDFT2(fourierImage)
image = IDFT(fourierImage);
image = IDFT(image')';
end