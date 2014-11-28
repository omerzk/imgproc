function fourierImage = DFT2(image)
%DFT2 returns the  discrete fourier transform of the input 2D signal
%cols
fourierImage = DFT(image);
%rows
fourierImage = DFT(fourierImage')';
end