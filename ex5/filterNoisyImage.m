I = imread('lena.png');
noiseVar = 0.04;
noiseMean = 0;%?
 x = random('norm', 0, 0.04,size(I,1),size(I,2));
 H = I+x;
J = imnoise(I,'gaussian', noiseMean, noiseVar);
denoisImage = denoising(H, lowFilt, highFilt, 6);