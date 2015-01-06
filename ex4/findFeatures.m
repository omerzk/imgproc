function [pos,desc] = findFeatures(pyr,maxNum)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% Arguments:
% pyr  Gaussian pyramid of a grayscale image having at least 3 levels.
% maxNum  Sets the maximal number of feature points to detect.
% Returns:
% pos  An nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc  A kxkxn feature descriptor matrix.
% %found = 0;
% %last = 0;
i = 1;
maxCorners = min([800 maxNum]);
% %corners = zeros(maxNum, 2);
[szX, szY] = size(pyr{1});

% %while (found < maxNum) && (i < length(pyr))
% %    %find the levels corners and transfer coordinates to pyr{1} 
% %    level_corners = ((spreadOutCorners(pyr{i}, 4, 4, maxCorners) - 1)* (2^ (i - 1))) + 1;
% %    level_corners = spreadOutCorners(pyr{i}, 4, 4, maxCorners);
% %    X = level_corners(:, 1);Y = level_corners(:, 2);
    % %filter invalid feature points - unsamplable in 3rd pyr level
% %    validPts = arrayfun(@(x,y)((12 < x < szX - 12) && (12 < y < szY - 12)), X, Y);
% %    validCorners = level_corners(validPts, :);
    %%save res and update points found and iteration
% %    [numOfPoints, ~] = size(validCorners);
% %    corners(last + 1:last + numOfPoints, :) = validCorners;
% %    last = last + numOfPoints;
% %    found = found + numOfPoints;
 % %   i = i + 1;
% %end
% %pos = corners(1 : found, :);
% %imshow(pyr{1})
% %hold on;
% %plot(pos,'r.','MarkerSize',10)
% %hold off;
% %desc = sampleDescriptor(pyr{3}, pos, 3);
%==========================================================================%
level_corners = spreadOutCorners(pyr{i}, 4, 4, maxCorners);
X = level_corners(:, 1);Y = level_corners(:, 2);
validPts = arrayfun(@(x,y)((12 < x < szX - 12) && (12 < y < szY - 12)), X, Y);
pos = level_corners(validPts, :);
imshow(pyr{1})
hold on;
plot(pos,'r.','MarkerSize',10)
hold off;
desc = sampleDescriptor(pyr{3}, pos, 3);

end

    
    