function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
%LaplacianPyramid produces the gaussian pyramid of the given image 
% under the maxlevels constraint and using afilter of the required size
    [Gpyr, filter] = GaussianPyramid(im, maxLevels, filterSize);
    lapFilter = filter * 2;
    shifted = Gpyr(2 : end);
    sz = size(Gpyr{end});
    shifted(end+1, 1) = {zeros(sz(1) / 2, sz(2) / 2)};
    %subtract each level in the gaussian pyramid from it's predecessor.
    %thus getting the laplacian pyramid
    pyr = cellfun(@(x,y){x - expand(y, lapFilter);}, Gpyr, shifted);

end

