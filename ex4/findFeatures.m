function [pos,desc] = findFeatures(pyr,maxNum)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% Arguments:
% pyr  Gaussian pyramid of a grayscale image having at least 3 levels.
% maxNum  Sets the maximal number of feature points to detect.
% Returns:
% pos  An nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc  A kxkxn feature descriptor matrix.
found = 0;
last = 0;
i = 1;
maxCorners = min([800 maxNum]);
corners = zeros(maxNum, 2);
while (found < maxNum) && (i < length(pyr))
    level_corners = spreadOutCorners(pyr{i}, 7, 7, maxCorners);
%     level_corners = corner(pyr{i},maxCorners);
    numOfPoints = length(level_corners);
    corners(last + 1:last + numOfPoints, :) = level_corners * (2^ (i - 1)) ;
    last = last + numOfPoints;
    found = found + numOfPoints;
    i = i+1;
end
pos = corners(1 : found, :);
imshow(pyr{1})
figure
plot(pos,'r.','MarkerSize',10)

desc = sampleDescriptor(pyr{3}, pos, 1);
end

    
    