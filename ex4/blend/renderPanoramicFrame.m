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

frameNotOK = false;
mask = zeros(panoSize(1:2));
%A vector of 2 panoramas one for the even images and one for the odd.
panoramaFrames = zeros([panoSize 2]);

%Transfer coordinates to the panorama coordinate system
homCenter = [imgSliceCenterX(:,1)';size(imgs, 1)/2; ones(1,size(imgSliceCenterX,1))];
Tcenters = zeros(size(imgSliceCenterX, 2),1);
for w = 1:size(Tcenters, 1)
    %same center since it's a constant vec.
    tHomCenter = T{w} * homCenter;
    Tcenters(w,:) = ceil((tHomCenter(1)/tHomCenter(3)))';
end

%Initiallize a vector of bounderies between the slices from each photo.
bounds = zeros(1,size(Tcenters, 1) + 1);
bounds(1) = Tcenters(1,1) - halfSliceWidthX;
bounds(1,2: end - 1) = round(((Tcenters(1: end - 1) + Tcenters(2 : end))/2)');
bounds(end) = Tcenters(end,1) + halfSliceWidthX;

halfbound = ceil(size(bounds,2)/2);

oddBounds = zeros(1, halfbound);
oddBounds(1) = bounds(1);
oddBounds(1, 2: end - 1) = round(((Tcenters(1:2: end - 2) + Tcenters(3 : 2 : end))/2)');
oddBounds(end) =  bounds(end);

evenBounds = zeros(1, halfbound);
evenBounds(1) =  bounds(1);
evenBounds(2: end - 1) =  round(((Tcenters(2:2: end - 1) + Tcenters(4: 2 : end))/2)');
evenBounds(end) =  bounds(end);
%====================================================================
%Backwarp to create the two panoramas and the blending mask.
for i = 1:size(imgs,4)
    if mod(i,2) ==0
        left = evenBounds(i/2); right = evenBounds(i/2 + 1);
        f = 2;
        %build the mask with white stripes on the even slices.
        maskLeft = bounds(i); maskRight = bounds(i + 1);
        mask(1:panoSize(1),maskLeft:maskRight) = 1;
    else
        left = oddBounds((i+1)/2); right = oddBounds((i+1)/2 + 1);
        f = 1;
    end
   [Y, X] = meshgrid(left : right,1 : panoSize(1));
   indexVec = [X(:) Y(:) ones(size(X(:)))]';
   %Apply tansformation (H) * [x1...xn;y1...yn](2xn)
   T{i}(1:2,3) = T{i}(2:-1:1,3);% wtf===============================
   prod = T{i} \ indexVec;
   invIndices = zeros(size(X));
   invIndices(:, :, 1) = reshape(prod(1, :)./prod(3, :), size(X));
   invIndices(:, :, 2) = reshape(prod(2, :)./prod(3, :), size(X));
   %filter frame where the desired image portion is undefined.
   if sum(sum(invIndices(:, :, 2) < 0)) > 0 || sum(sum(invIndices(:, :, 2) > size(imgs(:,:,3, i), 2))) > 0 
       frameNotOK = true;
       break;
   end
   clearvars prod indexVec
   %interpolate to find the value of the im in the subpixels we found
   %thus completing our backwarping.
   panoramaFrames(1:panoSize(1),left:right,1,f) = interp2(imgs(:,:,1, i),invIndices(:, :, 2), invIndices(:, :, 1),'bilinear');
   panoramaFrames(1:panoSize(1),left:right,2,f) = interp2(imgs(:,:,2, i),invIndices(:, :, 2), invIndices(:, :, 1),'bilinear');
   panoramaFrames(1:panoSize(1),left:right,3,f) = interp2(imgs(:,:,3, i),invIndices(:, :, 2), invIndices(:, :, 1),'bilinear');
end
    %Perform Pyramid Blending to merge the two panoramas together 
    panoramaFrame = rgbBlend(panoramaFrames(:,:,:,1), panoramaFrames(:,:,:,2),mask, 10, 3, 3);
end