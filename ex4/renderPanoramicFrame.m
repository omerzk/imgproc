function [panoramaFrame,frameNotOK]=renderPanoramicFrame(panoSize,imgs,T,imgSliceCenterX,halfSliceWidthX) 
% This function renders a panoramic frame. It takes the following steps:
% 1. Convert centers into panorama coordinates and find optimal width of
% each strip.
% 2. Backwarpping each strip from image to the panorama frames %
% Arguments:
% panoSize ? [yWidth,xWidth] of the panorama frame
% imgs ? The set of M images
% T ? The set of transformations (cell array) from each image to
% the panorama coordinates
% imgSliceCenterX ? A vector of 1xM with the required center of the strip
% in each of the images. This is given in image coordinates.
% sliceWidth ? The suggested width of each strip in the image %
% Returns:
% panoramaFrame? the rendered frame
% frameNotOK ? in case of errors in rednering the frame, it is true.
try
frameNotOK = false;
panoramaFrame = zeros(panoSize);
%transfer coordinates to the panorama coordinate system
Tcenters = T .* [imgSliceCenterX;...
    ones(size(imgSliceCenterX)) * size(imgs,1)/2];
%initiallize a vector of bounderies between the slices from each photo.
bounds = zeros(1, size(imgSliceCenterX, 2) + 1);
bounds(1) = Tcenters(1) - halfSliceWidthX;
bounds(2: end - 1) = (Tcenters(1:end - 1) + Tcenters(2 : end))/2;
bounds(end) = Tcenters(end) + halfSliceWidthX;
bounds = bounds - min(bounds);%??????????????????????????????????????????????????????????????????
%==============================================
for i = 1:size(imgs,1)
   left = bounds(i); right = bounds(i + 1);%readability counts
   [Y, X] = meshgrid(left : right,1 : panoSize(2));
   H = T(i);
   indexVec = [X(:) Y(:)]';
   %Apply tansformation inv(H) * [x1...xn;y1...yn](2xn)
   invIndices = reshape(H \ indexVec, [size(X) 2]);
   if isnan(invIndices(1,1,1))
       frameNotOK = true;
       break;
   end
   imsz = size(imgs(:, :, i));
   %Create the domain grids.
   [imY, imX] = meshgrid(1:imsz(2), 1:imsz(1));
   %interpolate to find the value of the im in the subpixels we found
   %thus completing our backwarping.
   panoramaFrame(left:right,1:panoSize(1)) = interp2(imY,imX,...
       imgs(:,:, i),invIndices(:, :, 2), invIndices(:, :, 1));
end
catch excpt
    frameNotOK = true;
    disp(excpt);
end