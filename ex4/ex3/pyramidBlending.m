function imBlend = pyramidBlending(im1, im2, mask, maxLevels, filterSizeIm, filterSizeMask)
%pyramidBlending Blends two images using pyramid belnding
%   the belnding is performed using laplacian pyramid blending with a mask
%   that weights every pixel in the photos to indicate how much to
%   combine from either photo in that pixel.
    [pyr1, filter1] = LaplacianPyramid(im1, maxLevels, filterSizeIm);
    [pyr2, ~] = LaplacianPyramid(im2, maxLevels, filterSizeIm);
    [maskPyr, ~] = GaussianPyramid(mask, maxLevels, filterSizeMask);
    %combined laplacian pyramid
    Lout = cellfun(@(L1, L2, Gm){(Gm .* L1) + ((1 - Gm) .* L2)}, pyr1, pyr2, maskPyr);
    imBlend = LaplacianToImage(Lout, filter1, ones(size(Lout))');

end

