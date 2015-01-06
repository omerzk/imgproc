function [ output_args ] = RANSAC( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


N = 1;
iter = 0;
p = 0.99;%the goal probability of finding model containing only inliers.
[rows, npts] = size(pos1); 
while N > iter
    invalid = 1;
    while invalid
        if 0
            indices = randsample(npts, s);
            
end

% Update estimate of N, the number of trials to ensure we pick, 
% with probability p, a data set with no outliers.
fracinliers =  ninliers/npts;
pNoOutliers = 1 -  fracinliers^s;
pNoOutliers = max(eps, pNoOutliers);  % Avoid division by -Inf
pNoOutliers = min(1-eps, pNoOutliers);% Avoid division by 0.
N = log(1-p)/log(pNoOutliers);

end

