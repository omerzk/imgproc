function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
    [Gpyr, reductionFilter] = GaussianPyramid(im, maxLevels, filterSize);
    filter = reductionFilter * 2;
    shifted = Gpyr(2 : end);
    shifted(1,end+1) = {zeros(length(Gpyr{end})/2)};
    pyr = cellfun(@(x,y){x - expand(y)}, Gpyr, shifted);
    
    function  expansion = expand(level)
        padding = zeros(size(level) * 2);
        padding(1:2:end,1:2:end) = level;
        expansion = conv2(conv2(padding, filter, 'same'),filter','same');
    end
end

