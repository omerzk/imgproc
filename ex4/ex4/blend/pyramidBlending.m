function imBlend = pyramidBlending(im1, im2, mask, maxLevels, filterSizeIm, filterSizeMask)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [pyr1, filter1] = LaplacianPyramid(im1, maxLevels, filterSizeIm);
    [pyr2, ~] = LaplacianPyramid(im2, maxLevels, filterSizeIm);
    [maskPyr, ~] = GaussianPyramid(mask, maxLevels, filterSizeMask);
    Lout = cellfun(@(L1, L2, Gm){(Gm .* L1) + ((1 - Gm) .* L2)}, pyr1, pyr2, maskPyr);
    imBlend = LaplacianToImage(Lout, filter1/2, ones(size(Lout)));

end

