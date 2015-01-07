function [pos,desc] = findFeatures(pyr,maxNum)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% Arguments:
% pyr  Gaussian pyramid of a grayscale image having at least 3 levels.
% maxNum  Sets the maximal number of feature points to detect.
% Returns:
% pos  An nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc  A kxkxn feature descriptor matrix.

% %maxCorners = min([800 maxNum]);???????
maxCorners = maxNum;
found = 0; i = 1;
pos = zeros(maxCorners, 2);
desc = zeros(7,7, maxCorners);
while (found < maxCorners) && (i < size(pyr,1) - 2)%the 2 is so that an upsample can always be taken per instructions
    [szX, szY] = size(pyr{i});
    %find the levels corners and transfer coordinates to pyr{1} 
    level_corners = spreadOutCorners(pyr{i}, 4, 4, maxCorners);
    %filter invalid feature points - unsamplable in i+2 pyr level
    X = level_corners(:, 1);Y = level_corners(:, 2);
    validPts = arrayfun(@(x,y)((12 < x < szX - 12) && (12 < y < szY - 12)), X, Y);
    validCorners = level_corners(validPts, :);
    %save res and update points found and iteration
    [numOfPoints, ~] = size(validCorners);
    pos(found + 1:found + numOfPoints, :) = validCorners;
    %upsamle a descriptor
    desc(:, :, found + 1:found + numOfPoints) = sampleDescriptor(pyr{i + 2}, validCorners, 3);
    %update iteration number of features detected and index
    % %last = last + numOfPoints;
    found = found + numOfPoints;
    i = i + 1;
end
%trim
pos = pos(1 : found, :);
desc = desc(:, :, 1 : found);
%bells and whistles
imshow(pyr{1})
hold on;
plot(pos(:,1),pos(:,2),'r.','MarkerSize',10)
hold off;
%==========================================================================%
% % maxCorners = maxNum;
% % [szX, szY] = size(pyr{1});
% % level_corners = spreadOutCorners(pyr{i}, 4, 4, maxCorners);
% % X = level_corners(:, 1);Y = level_corners(:, 2);
% % validPts = arrayfun(@(x,y)((12 < x < szX - 12) && (12 < y < szY - 12)), X, Y);
% % pos = level_corners(validPts, :);
% % imshow(pyr{1})
% % hold on;
% % plot(pos,'r.','MarkerSize',10)
% % hold off;
% % desc = sampleDescriptor(pyr{3}, pos, 3);

end

    
    