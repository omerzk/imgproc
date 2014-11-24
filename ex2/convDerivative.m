function magnitude = convDerivative(inImage)
f_x = conv2(inImage,[1 0 -1],'same');
imshow(f_x,[])
f_y = conv2(inImage,[1;0;-1],'same');
magnitude = sqrt((f_x.^2)+(f_y.^2));
end