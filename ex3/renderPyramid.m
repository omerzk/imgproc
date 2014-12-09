function res = renderPyramid(pyr, levels)
    dim = size(pyr{1});
    dims(1:levels) = dim(1);
    sizeB = sum(dims./(2.^(1:levels)));
    res = cell(1,sizeB);
    reqPyr = pyr(1:levels);
    res(1:dim(1),1:dim(2)) = pyr{1};
    start = dim(1);
    cellfun(@accumelate , reqPyr(2:end))
 
     function accumelate(lvl)
         curdim = size(lvl);
         res(1:curdim(1),start:start + curdim(2))
     end
 end