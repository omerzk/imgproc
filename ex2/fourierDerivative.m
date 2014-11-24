function magnitude = fourierDerivative(inImage)
fourierIm = DFT2(inImage);
[rows,cols]  = size(inImage);
if mod(rows,2)==0
    rows = rows-1;
end
if mod(cols,2)==0
    cols = cols-1;
end
v = diag(cat(2,0:cols/2, cols / 2:-1:0));
u = diag(cat(2,0:cols/2, cols / 2:-1:0));
f_x = IDFT2((fourierIm * u));
f_y = IDFT2((v * fourierIm));
magnitude = sqrt((f_x.^2)+(f_y.^2));