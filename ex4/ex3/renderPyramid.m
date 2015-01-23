function res = renderPyramid(pyr, levels)
% renderPyramid renders the required levels  input pyramid in a single
% image 
    %init
    dim = size(pyr{1});
    width = sum(dim(2)./(2.^(0:levels-1)));
    res = ones(dim(1), width);
    reqPyr = pyr(1:levels);
    res(1:dim(1), 1:dim(2)) = pyr{1};
    start = dim(2)+1;
    %=================
    cellfun(@accumelate , reqPyr(2:end))
    %insert required levels into result
     function accumelate(lvl)
         curdim = size(lvl);
         res(1 : curdim(1), start : start + curdim(2)-1) = lvl;
         start = start + curdim(2);
     end
 end