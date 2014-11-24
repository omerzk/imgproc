function fourierImage = DFT2(image)
fourierImage = DFT(image);
fourierImage = DFT(fourierImage')';
end