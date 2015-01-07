function [T,inliers] = ransacTransform(pos1,pos2,numIters,inlierTol)
% Fit transform to maximal inliers given point matches
% using the RANSAC algorithm.
%
% Arguments:
% pos1,pos2 − Two nx2 matrices containing n rows of [x,y] coordinates of
% matched points.
% numIters − Number of RANSAC iterations to perform.
% inlierTol − inlier tolerance threshold. When determining if a given match,
% e.g. between pos1(i,:) and pos2(i,:), is an inlier match, the squared euclidean
% distance between the transformed pos1(i,:) and pos2(i,:) is computed and
% compared to inlierTol. Matches having this squared distance smaller than
% inlierTol are treated as inliers.
%
% Returns:
% T − A 3x3 matrix, where T(1,3) is dX and T(2,3) is dY.
% inliers − An array containing the indices in pos1/pos2 of the maximal set of
% inlier matches found.
%
% Description:
% To determine if a given match, e.g. between pos1(i,:) and pos2(i,:), is an
% inlier match, the squared euclidean distance between the transformed pos1(i,:)
% and pos2(i,:) is computed and compared to inlierTol
s = 2; 
[rows, npts] = size(pos1);

for k = 1:numIters
    indices = randsample(npts, s);
    
    
end

% function [ output_args ] = RANSAC( input_args )
% %UNTITLED Summary of this function goes here
% %   Detailed explanation goes here
% 
% 
% N = 1;
% iter = 0;
% p = 0.99;%the goal probability of finding model containing only inliers.
% [rows, npts] = size(pos1); 
% while N > iter
%     invalid = 1;
%     while invalid
%         if 0
%             indices = randsample(npts, s);
%         end
%     end
% end
% 
% % Update estimate of N, the number of trials to ensure we pick, 
% % with probability p, a data set with no outliers.
% fracinliers =  ninliers/npts;
% pNoOutliers = 1 -  fracinliers^s;
% pNoOutliers = max(eps, pNoOutliers);  % Avoid division by -Inf
% pNoOutliers = min(1-eps, pNoOutliers);% Avoid division by 0.
% N = log(1-p)/log(pNoOutliers);
% 
% end

