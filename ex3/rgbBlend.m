function blended = rgbBlend(im1,im2, mask, maxlevels,filterSizeIm,filterSizeMask)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    imBlendR = pyramidBlending(im1(:,:,1), im2(:,:,1), mask, maxlevels, filterSizeIm, filterSizeMask);
    imBlendG = pyramidBlending(im1(:,:,2), im2(:,:,2), mask, maxlevels, filterSizeIm, filterSizeMask);
    imBlendB = pyramidBlending(im1(:,:,3), im2(:,:,3), mask, maxlevels, filterSizeIm, filterSizeMask);
    blended(:,:,1) = imBlendR;blended(:,:,2) = imBlendG;blended(:,:,3) = imBlendB;

end

