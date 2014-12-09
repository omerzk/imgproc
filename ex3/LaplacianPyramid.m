function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
    [Gpyr, reductionFilter] = GaussianPyramid(im, maxLevels, filterSize);
    filter = reductionFilter * 2;%is this what they meant?? 
    shifted = Gpyr(2 : end);
    if(size(Gpyr{end}) == [1 1])
        %imshow(Gpyr{1});
    end
    size(Gpyr{end})
    shifted(1,end+1) = {zeros(length(Gpyr{end})/2)};
    pyr = cellfun(@(x,y){x - expand(y, filter)}, Gpyr, shifted);
    
%     function  expansion = expand(level)
%         padding = zeros(size(level) * 2);
%         padding(1:2:end,1:2:end) = level;
%         expansion = conv2(conv2(padding, filter, 'same'),filter','same');
%     end
end

