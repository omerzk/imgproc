lowFilt = [0.5 0.5];
 highFilt = [-0.5 0.5];
I = im2double(imread('lena.png'));
noiseVar = 0.001;
noiseMean = 0;%?
J = imnoise(I, 'gaussian', noiseMean, noiseVar);

denoisImage = denoising(J, lowFilt, highFilt, 3);