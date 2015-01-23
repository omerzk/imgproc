function blended = rgbBlend(im1,im2, mask, maxlevels,filterSizeIm,filterSizeMask)
%rgbBlend blends two rgb images using the pyramidblend function
    %seperate channels
    imBlendR = pyramidBlending(im1(:,:,1), im2(:,:,1), mask(:,:,1), maxlevels, filterSizeIm, filterSizeMask);
    imBlendG = pyramidBlending(im1(:,:,2), im2(:,:,2), mask(:,:,2), maxlevels, filterSizeIm, filterSizeMask);
    imBlendB = pyramidBlending(im1(:,:,3), im2(:,:,3), mask(:,:,3), maxlevels, filterSizeIm, filterSizeMask);
  
    blended(:,:,1) = imBlendR; blended(:,:,2) = imBlendG; blended(:,:,3) = imBlendB;

end

