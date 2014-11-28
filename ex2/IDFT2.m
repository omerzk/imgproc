function image = IDFT2(fourierImage)
%IDFT2 returns the invesre discrete fourier transform of the input 2D signal
%rows
image = IDFT(fourierImage);
%cols
image = IDFT(image')';
end