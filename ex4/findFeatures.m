function [pos,desc] = findFeatures(pyr,maxNum)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% Arguments:
% pyr  Gaussian pyramid of a grayscale image having at least 3 levels.
% maxNum  Sets the maximal number of feature points to detect.
% Returns:
% pos  An nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc  A kxkxn feature descriptor matrix.
maxCorners = maxNum;
found = 0; i = 1;
pos = zeros(maxCorners, 2);
desc = zeros(7, 7, maxCorners);
brdrSpc = 32;
%change i<= 1 for single level mops DEBUGGING, size(pyr,2) - 2 for multi level
while (found < maxCorners) && (i <= size(pyr,2) - 2)
    %find the level's corner
    [szX, szY] = size(pyr{i});
    %trim edges so that no unsamplable intrest points are found.
    trimmed = pyr{i}(brdrSpc : szX - brdrSpc, brdrSpc: szY- brdrSpc);
    level_corners = spreadOutCorners(trimmed, 7, 7, maxCorners) + brdrSpc;
    %reverse the result since it's [y x] and i like [x y] better.
    level_corners = level_corners(:, 2:-1:1);
    [numOfPoints, ~] = size(level_corners);
    %convert to pyr level 1 coordinates and store.
    pos(found + 1:found + numOfPoints, :) = ((level_corners - 1) * 2^(1 - i)) + 1 ;
    %upsamle a descriptor
    desc(:, :, found + 1:found + numOfPoints) = sampleDescriptor(pyr{i + 2}, level_corners, 3);
    %iteration update
    maxCorners = maxCorners - numOfPoints;
    found = found + numOfPoints;
    i = i + 1;
end
%trim
pos = pos(1 : found, :);
desc = desc(:, :, 1 : found);


imshow(pyr{1})
hold on;
plot(pos(:,2),pos(:,1),'r.','MarkerSize',10)
hold off;
end

    
    