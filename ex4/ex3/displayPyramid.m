function displayPyramid(pyr,levels)
%displayPyramid display a rendering of #levels of pyr.
    figure('name', 'Pyramid','NumberTitle', 'off'); imshow(renderPyramid(pyr, levels));

end

