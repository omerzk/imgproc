function res = renderPyramid(pyr, levels)
    dims = size(pyr{1});
    reqPyr = pyr(1:levels);
    res = pyr{1};
    cellfun(@accumelate , reqPyr(2:end))

    function accumelate(lvl)
        curdim = size(lvl);
        res = cat(2, res, padarray(lvl,dims(1) - curdim(1), 255, 'post'));
    end
end