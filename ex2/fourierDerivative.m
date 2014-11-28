function magnitude = fourierDerivative(inImage)
%fourierDerivative returns the maginitude of the gradiendt of the
%input 2D signal using 2d fourier transform
fourierIm = DFT2(inImage);
[rows,cols]  = size(inImage);
if mod(rows,2)==0
    rows = rows-1;
end

if mod(cols,2)==0
    cols = cols-1;
end
%diagonal matrices such that matrix multiplications will result 
%in multipling the it'h row/col by the it'h member of the main diagonal.
v = diag(cat(2,0:floor(rows / 2), ceil(-rows / 2):0));
u = diag(cat(2,0:floor(cols / 2), ceil(-cols / 2) : 0));
%partial derivatives
f_x = IDFT2((fourierIm * u * (2*pi*1i/cols)));
f_y = IDFT2((v * fourierIm * (2*pi*1i/rows)));
magnitude = sqrt((f_x.^2)+(f_y.^2));
end