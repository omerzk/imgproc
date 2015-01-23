function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
    [Gpyr, reductionFilter] = GaussianPyramid(im, maxLevels, filterSize);
    filter = reductionFilter * 2;%is this what they meant?? 
    shifted = Gpyr(2 : end);
    shifted(1,end+1) = {zeros(size(Gpyr{end})/2)};
    pyr = cellfun(@(x,y){x - expand(y, filter)}, Gpyr, shifted);
    
end

