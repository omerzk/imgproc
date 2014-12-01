function magnitude = fourierDerivative(inImage)
%fourierDerivative returns the maginitude of the gradiendt of the
%input 2D signal using 2d fourier transform
fourierIm = DFT2(inImage);
[rows,cols]  = size(inImage);

%factoring for an even/uneven photo
colFactor = 0; rowFactor = 0;
if mod(rows,2) == 0
   rowFactor = -1;
end
if mod(cols,2) == 0
    colFactor = -1;
end

%diagonal matrices such that matrix multiplications will result 
%in multipling the it'h row/col by the it'h member of the main diagonal.
v = diag(cat(2,0 : floor(rows / 2) + rowFactor, ceil(-rows / 2) : -1));
u = diag(cat(2,0 : floor(cols / 2) + colFactor, ceil(-cols / 2) : -1));
%partial derivatives
f_x = IDFT2((fourierIm * u * (2*pi*1i/cols)));
f_y = IDFT2((v * fourierIm * (2*pi*1i/rows)));

magnitude = sqrt((f_x.^2)+(f_y.^2));
figure('name', 'Fourier Magnitude','NumberTitle', 'off'); imshow(magnitude);
end