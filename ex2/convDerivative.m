function magnitude = convDerivative(inImage)
%convDerivative returns the maginutude of the gradient of hte 2d input
%matrix using convolution.
%partial derivatives
f_x = conv2(inImage,[1 0 -1],'same');
f_y = conv2(inImage,[1;0;-1],'same');

magnitude = sqrt((f_x.^2)+(f_y.^2));
figure('name', 'Conv Magnitude','NumberTitle', 'off'); imshow(magnitude);
end